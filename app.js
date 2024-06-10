const express = require('express');
const path = require("path")
const bcrypt = require('bcrypt')
const mysql = require('mysql');
const app = express();
const session = require('express-session');

// Add this line before defining your routes
app.use(session({
    secret: 'your_secret_key',
    resave: false,
    saveUninitialized: false
}));

// MySQL database connection
const con = mysql.createConnection({
    host: "localhost",
    user: "root",
    port: 3306,
    password: "12345678",
    database: "inventario"
});

con.connect(function (err) {
    if (err) throw err;
    console.log("Connected to MySQL database!");
});

app.set('view-engine', 'ejs')
app.use(express.urlencoded({ extended: false }))
app.use(express.static(path.join(__dirname, 'public')));

app.get("/", (req, res) => {
    res.render('index.ejs', { user: req.session.user });
})

app.get("/login", (req, res) => {
    res.render('login.ejs')
})

app.post("/login", async (req, res) => {
    const { email, password } = req.body;
    const sql = 'SELECT * FROM inventario.empleado WHERE correo_emp = ?';
    con.query(sql, [email], async (err, rows) => {
        if (err) {
            console.error("Error querying user:", err);
            return res.redirect('/login');
        }
        if (rows.length === 0) {
            return res.redirect('/login'); // User with the provided email does not exist
        }

        const user = rows[0]; // Assuming only one user will match the provided email
        const passwordMatch = await bcrypt.compare(password, user.contrasena_emp);
        if (!passwordMatch) {
            return res.redirect('/login'); // Passwords don't match
        }

        // At this point, authentication is successful, you can redirect to a secure page or set up a session
        // For example, you can set a session and redirect to the home page:
        req.session.user = user;
        res.redirect('/');
    });
});

app.get("/logout", (req, res) => {
    // Destroy the session
    req.session.destroy(err => {
        if (err) {
            console.error("Error destroying session:", err);
            return res.redirect('/');
        }
        // Redirect the user to the home page or login page
        res.redirect('/');
    });
});

app.get("/register", (req, res) => {
    res.render('register.ejs')
})

app.post("/register", async (req, res) => {
    try {
        const hashedPassword = await bcrypt.hash(req.body.password.toString(), 10);
        const userData = {
            nombre_emp: req.body.name,
            apellido_emp: req.body.lname,
            rol_emp: req.body.role,
            correo_emp: req.body.email,
            contrasena_emp: hashedPassword,
        };
        const sql = 'INSERT INTO inventario.empleado SET ?';
        con.query(sql, userData, (err, result) => {
            if (err) {
                console.error("Error inserting user data:", err);
                return res.redirect('/register');
            }
            console.log("User data inserted successfully:", result);
            res.redirect('/login');
        });
    } catch (error) {
        console.error("Error registering user:", error);
        res.redirect('/register');
    }
})

app.get("/prov", (req, res) => {
    con.query("SELECT * FROM proveedor", function (err, result) {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving proveedores");
        } else {
            console.log("Proveedor data:", result); // This will output the retrieved data
            res.render('prov.ejs', { proveedor: result, user: req.session.user });
        }
    });
});
app.post("/reg-prov", (req, res)=>{
    try{
        const provData = {
            nombre_prov : req.body.name,
            apellido_prov : req.body.lname,
            empresa_prov : req.body.empresa,
            correo_prov : req.body.email,
            terminos_pago : req.body.pago,
            dir_prov : req.body.dir,
            telefono_prov : req.body.tel
        };
        const sql = 'INSERT INTO inventario.proveedor SET ?';
        con.query(sql, provData, (err, result)=>{
            if (err) {
                console.error("Error inserting prov data:", err);
                return res.redirect('/prov');
            }
            console.log("Prov data inserted successfully:", result);
            res.redirect('/prov');
        });

    }catch(error){
        console.error("Error registering prov:", error);
        res.redirect('/');
    }
})

app.get("/inventario", (req, res) => {
    // Fetch all products
    con.query("SELECT p.*, pr.nombre_prov, pr.apellido_prov, pr.empresa_prov FROM producto p JOIN proveedor pr ON p.fk_prov = pr.id_prov", function (err, productos) {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving productos");
            return;
        }

        // Fetch kits along with their associated products
        con.query("SELECT kp.id_kit_producto, k.*, kp.fk_pro, p.nombre_pro FROM kit k JOIN kit_producto kp ON k.id_kit = kp.fk_kit JOIN producto p ON kp.fk_pro = p.id_pro", function (err, kits) {
            if (err) {
                console.error(err);
                res.status(500).send("Error retrieving kits");
                return;
            }

            // Restructure the data to group products by kit
            const kitsWithProducts = [];

            // Create an object to track processed kits
            const processedKits = {};

            // Iterate through each kit and associate products
            kits.forEach(kit => {
                // If the kit is not processed yet, add it to kitsWithProducts
                if (!processedKits[kit.id_kit]) {
                    kitsWithProducts.push({
                        id_kit: kit.id_kit,
                        nombre_kit: kit.nombre_kit,
                        precio_kit: kit.precio_kit,
                        productos: []
                    });
                    processedKits[kit.id_kit] = true; // Mark kit as processed
                }

                // Find the index of the current kit in kitsWithProducts
                const index = kitsWithProducts.findIndex(k => k.id_kit === kit.id_kit);

                // Add the current product to the productos array of the corresponding kit
                kitsWithProducts[index].productos.push({ nombre_pro: kit.nombre_pro });
            });

            console.log("Productos data:", productos);
            console.log("Kits data:", kitsWithProducts);
            res.render('inventario.ejs', { productos: productos, kits: kitsWithProducts, user: req.session.user });
        });
    });
});




app.get("/add-prod",(req,res)=>{
    // Para poder ver la lista de proveedores
    con.query("SELECT * FROM proveedor", function (err, result) {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving proveedores");
        } else {
            console.log("Proveedores data:", result); // This will output the retrieved data
            res.render('add-prod.ejs', { prov: result });
        }
    });
})

app.post("/buy-prod", (req,res) =>{
    try {
        const provData = {
            nombre_pro: req.body.name,
            descripcion_pro: req.body.info,
            cantidad_pro: req.body.stock,
            ubicacion_pro: req.body.ubi,
            fecha_venc: req.body.date,
            precio_pro: req.body.precio,
            fk_emp : 13,
            fk_prov : req.body.prov
        };
        const sql = 'INSERT INTO inventario.producto SET ?';
        con.query(sql, provData, (err, result) => {
            if (err) {
                console.error("Error inserting prod data:", err);
                return res.redirect('/add-prod');
            }
            console.log("Prod data inserted successfully:", result);
            res.redirect('/inventario');
        });

    } catch (error) {
        console.error("Error registering prod:", error);
        res.redirect('/');
    }
})

// Muestra productos y kit
app.get('/add-kit', (req, res) => {
    con.query("SELECT * FROM producto", function (err, prodResult) {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving productos");
        } else {
            console.log("Producto data:", prodResult); // This will output the retrieved data

            // Execute second query to retrieve data from another table
            con.query("SELECT * FROM kit", function (err, kitResult) {
                if (err) {
                    console.error(err);
                    res.status(500).send("Error retrieving kits");
                } else {
                    console.log("Kit data:", kitResult); // This will output the retrieved data
                    res.render('add-kit.ejs', { prod: prodResult, kit: kitResult });
                }
            });
        }
    });
});

app.post('/new-kit', (req,res) =>{
    try {
        const kitData = {
            nombre_kit: req.body.name,
            precio_kit: req.body.precio,
            fk_emp: 13,
        };
        const sql = 'INSERT INTO inventario.kit SET ?';
        con.query(sql, kitData, (err, result) => {
            if (err) {
                console.error("Error inserting kit data:", err);
                return res.redirect('/add-kit');
            }
            console.log("kit data inserted successfully:", result);
            res.redirect('/inventario');
        });

    } catch (error) {
        console.error("Error registering kit:", error);
        res.redirect('/');
    }
})

// Asocia kit y productos en nueva tabla
app.post('/prod-to-kit', (req,res)=>{
    try {
        const buildkitData = {
            fk_kit: req.body.kit,
            fk_pro: req.body.prod,
        };
        const sql = 'INSERT INTO inventario.kit_producto SET ?';
        con.query(sql, buildkitData, (err, result) => {
            if (err) {
                console.error("Error inserting kit data:", err);
                return res.redirect('/add-kit');
            }
            console.log("kit data inserted successfully:", result);
            res.redirect('/add-kit');
        });

    } catch (error) {
        console.error("Error registering kit:", error);
        res.redirect('/');
    }
})

app.listen(3000, () => {
    console.log("Server listening running on port 3000");
})
