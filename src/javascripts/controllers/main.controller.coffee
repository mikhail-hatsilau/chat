(->

  MainController = ($scope, SocketService) ->
    init = =>
      @users = []
      @entered = false
      @enter = enter
      listenUserConnection()

    #########

    enter = () =>
      SocketService.emit 'connect user', @username, () =>
        $scope.$apply () =>
          @users.push @username
          @entered = true

    listenUserConnection = =>
      SocketService.on 'user connected', (user) =>
        $scope.$apply () =>
          @users.push user

    init()

    return

  MainController.$inject = ['$scope', 'SocketService']

  angular
    .module 'chatApp'
    .controller 'MainController', MainController

)()
