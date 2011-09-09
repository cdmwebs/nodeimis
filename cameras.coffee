Backbone = require 'backbone'
nodeio   = require 'node.io'

couch = require('backbone-couch')(
  host: '127.0.0.1'
  port: '5984'
  name: 'cincytraffic')

couch.install()
Backbone.sync = couch.sync

class ScrapeCameras extends nodeio.JobClass
  baseURL: 'http://www.artimis.org'
  cameras: new Cameras
  benchmark: true
  timeout: 5
  max: 5

  input: (start, num, callback) ->
    @getHtml "#{@baseURL}/cameraselect.php", (err, $) ->
      @exit err if err?
      $('a[href*="camera/"]').each (link) =>
        camera = new Camera(location: link.text, href: "#{@baseURL}#{link.attribs.href}")
        @cameras.add(camera)
        callback [camera]
      callback null, false

  run: (camera) ->
    @getHtml camera.get('href'), (err, $) ->
      @exit err if err?
      image = $('img[name=refimage]')
      camera.set(imageURL: image.attribs.src)
      camera.save()
      @emit camera

@class = ScrapeCameras
@job = new ScrapeCameras(timeout: 0)
