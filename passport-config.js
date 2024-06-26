const { authenticate } = require('passport')
const bcrypt = require('bcrypt')

const LocalStrategy = require('passport-local').Strategy

async function initialize(passport, getUserByEmail, getUserById) {
    const authenticateUser = async (email, password, done) => {
        const user = getUserByEmail(email)
        if (user == null) {
            return done(null, false, { message: 'No user with this email' })
        }

        try {
            if (await bcrypt.compare(password, user.password)) {
                return done(null, user)
            } else {
                return done(null, false, { message: 'Password incorrect' })
            }
        } catch (e) {
            return done(e)
        }
    }
    passport.use(new LocalStrategy({ usernameField: 'email' }, authenticateUser))

    passport.serializeUser((user, done) => {
        done(null, user.id)
    })

    passport.deserializeUser((id, done) => {
        const user = getUserById(id)
        done(null, user)
    })
}

module.exports = initialize
