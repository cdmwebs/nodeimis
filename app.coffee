app = require('express').createServer()

app.set 'view options', layout: false
app.set 'view engine', 'coffee'

browserify = require("browserify")
app.use browserify
  mount: "/browserify.js"
  require: ["underscore", "backbone", "jquery-browserify"]

app.get '/', (req, res) ->
  res.render 'index.coffeekup', { title: 'My Site' }

app.get '/map', (req, res) ->
  res.render 'map.coffeekup', { title: 'My Site' }

app.listen(3000)
