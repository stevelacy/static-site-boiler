passport = require "./passport"
config = require "../config"
app = require "./express"


app.get "/", (req, res) ->
  return res.redirect "/login" unless req.user?
  res.render "index", user: req.user

app.get "/logout", (req, res) ->
  req.logout()
  res.redirect "/"

app.get "/login", (req, res) ->
  #return res.redirect "/" if req.user?
  res.render "login"


app.get "/auth/twitter", passport.authenticate "twitter"
app.get "/auth/twitter/callback",
  passport.authenticate "twitter",
    successRedirect: "/"
    falureRedirect: "/login"
