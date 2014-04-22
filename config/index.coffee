keys = require "./keys"
module.exports = 

  port: 5000
  name: "claire"
  nickname: "C.L.A.I.R.E"
  fullname: "Control Leveraging Artificial Intelligence Realu Ecosystem"
  owner: "Steve Lacy"
  address: "Sir"
  keys: keys
  mongo:
    url: "mongodb://127.0.0.1:27017/claire"
    host: "127.0.0.1"
    port: 27017
    sessionDb: "rialu-session"
  session:
    secret: "b1d8d68e863cbbf5b6eac491ad52972d2e8559369c34a5add78913eab3d9fa3d"
    key: "express.sid"
  twitter:
    callback: "/auth/twitter/callback"