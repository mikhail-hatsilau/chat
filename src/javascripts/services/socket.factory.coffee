(->

  SocketService = () ->
    socket = io.connect 'http://localhost:3000'

    return {
      on: (eventName, callback) ->
        socket.on eventName, (data) ->
          callback data
      emit: (eventName, data, callback) ->
        socket.emit eventName, data, () ->
          callback()
    }

  angular
    .module 'chatApp'
    .factory 'SocketService', SocketService
)()
