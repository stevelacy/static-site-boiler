mongoose = require 'mongoose'
passport = require "passport"
TwitterStrategy = require("passport-twitter").Strategy

db = require './db'
config = require '../config'

User = db.models.User


handleFunction = (token, tokenSecret, profile, cb) ->
  console.log profile
  User.findOne {id: profile.id}, (err, user) ->
    return cb err if err?
    #icon = profile._json.profile_image_url_https.replace('_normal', '')
    icon = profile._json.profile_image_url_https
    profileUpdate =
      username: profile._json.screen_name
      icon: icon
      id: Number profile._json.id
    if user?
      user.set profileUpdate
      user.save()
      cb null, user
    else
      User.create profileUpdate, (err, doc) ->
        return cb err if err?
        cb null, doc

strategy = new TwitterStrategy
  consumerKey: config.keys.twitter.key
  consumerSecret: config.keys.twitter.secret
  callbackURL: config.twitter.callback
, handleFunction

passport.use strategy

passport.serializeUser (user, cb) ->
  cb null, user.id

passport.deserializeUser (id, cb) ->
  User.findOne {id: id}, cb


module.exports = passport