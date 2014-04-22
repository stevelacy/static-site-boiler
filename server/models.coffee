mongoose = require "mongoose"

User = new mongoose.Schema
  username:
    type: String
    required: true
    unique: true
  name: type: String
  id: type: Number
  icon: type: String
  source: String




User.set "autoindex", false
exports.User = mongoose.model "User", User
