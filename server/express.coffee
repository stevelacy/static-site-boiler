path = require "path"
stylus = require "stylus"
express = require "express"

config = require "../config"
passport = require "./passport"
sessionStore = require "./sessionstore"

app = express()
app.use stylus.middleware
  src: path.resolve __dirname, "../client"
  compile: (str, path) ->
    stylus str 
      .set "filename", path
app.use express.static path.resolve __dirname, "../client"
app.set "views", path.resolve __dirname, "../views"
app.set "view engine", "jade"
app.use express.json()
app.use express.urlencoded()
app.use express.cookieParser()
app.use express.session
  store: sessionStore
  key: config.session.key
  secret: config.session.secret
  maxAge: new Date(Date.now() + 3600000)
  expires: new Date(Date.now() + 3600000)

app.use passport.initialize()
app.use passport.session()

module.exports = app
