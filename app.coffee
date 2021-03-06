express = require 'express'
http = require 'http'
path = require 'path'
favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
socketio = require 'socket.io'
routes = require './routes/index'

app = express()
server = http.Server app
io = socketio server

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

# uncomment after placing your favicon in /public
#app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded({ extended: false })
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

app.use '/', routes

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

# error handlers

# development error handler
# will print stacktrace
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error', {
      message: err.message,
      error: err
    }

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status || 500
  res.render 'error', {
    message: err.message,
    error: {}
  }

#socket events
io.on 'connection', (socket) ->
  socket.on 'connect user', (user, callback) ->
    console.log user
    socket.broadcast.emit 'user connected', user
    callback()

server.listen 3000

module.exports = app
