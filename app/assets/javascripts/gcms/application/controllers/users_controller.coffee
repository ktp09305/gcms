UsersController = ($scope, $state, $cookieStore, Restangular, $stateParams) ->
  $scope.store = Restangular.all('users')
  $scope.store.getList().then (users)->
    $scope.users = users

  if $stateParams.id
    $scope.store.get($stateParams.id).then (user)->
      $scope.user = user
  else
    $scope.user = {role: 'content_manager'}

  $scope.create = ->
    $scope.store.customPOST($scope.user, 'from_gcms').then ->
      $state.go('users')
    ,->
      console.log('bug')

  #$scope.update = ->
    #$scope.user.put().then ->
      #$state.go('users')
    #,->
      #console.log('bug')

  $scope.destroy = (user)->
    user.remove().then ->
      $scope.users = _.without($scope.users, user)


angular.module('GCMS')
    .controller('UsersController', ['$scope', '$state', '$cookieStore', 'Restangular', '$stateParams', UsersController])

