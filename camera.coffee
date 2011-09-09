Backbone = require('backbone')

class Camera extends Backbone.Model
  defaults:
    type: 'camera'
    location: ''
    href: ''
    latitude: null
    longitude: null

class Cameras extends Backbone.Collection
  model: Camera
  url: "http://localhost:5984/documents/_design/backbone/_rewrite/cameras/"

require('./backbone-couchdb')
Backbone.couch_connector.config.db_name = "backbone-couchapp"
Backbone.couch_connector.config.ddoc_name = "backbone-couchapp"
Backbone.couch_connector.config.global_changes = false

exports.Camera = Camera
exports.Cameras = Cameras
