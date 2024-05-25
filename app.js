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
            res.render('prov.ejs', { proveedor: result });
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

app.get("/inventario", (req,res)=>{
    con.query("SELECT * FROM producto", function (err, result) {
        if (err) {
            console.error(err);
            res.status(500).send("Error retrieving productos");
        } else {
            console.log("Productos data:", result); // This will output the retrieved data
            res.render('inventario.ejs', { prod : result });
        }
    });
});

app.get("/add-prod",(req,res)=>{
    res.render("add-prod.ejs")
})

app.post("/buy-prod", (req,res) =>{
    try {
        const provData = {
            nombre_pro: req.body.name,
            descripcion_pro: req.body.info,
            cantidad_pro: req.body.stock,
            ubicacion_pro: req.body.ubi,
            fecha_venc: req.body.date,
            kit_pro: req.body.kit,
            precio_pro: req.body.precio
        };
        const sql = 'INSERT INTO inventario.producto SET ?';
        con.query(sql, provData, (err, result) => {
            if (err) {
                console.error("Error inserting prod data:", err);
                return res.redirect('/add-prod');
            }
            console.log("Prod data inserted successfully:", result);
            res.redirect('/add-prod');
        });

    } catch (error) {
        console.error("Error registering prod:", error);
        res.redirect('/');
    }
})

app.listen(3000, () => {
    console.log("Server listening running on port 3000");
})
