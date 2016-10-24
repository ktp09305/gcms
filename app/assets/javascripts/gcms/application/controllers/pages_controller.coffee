PagesController = ($scope, $state, $cookieStore, Restangular, $stateParams, Alertify, ErrorsService) ->
  $scope.editorOptions =
    #filebrowserBrowseUrl: '/assets/asset/file'
    filebrowserUploadUrl: '/gcms/assets/ckeditor'
    entities: false
  $scope.codeMirrorOptions =
    lineNumbers: true
    mode:'htmlmixed'
    autoCloseTags: true
    matchTags:
      bothTags: true
    extraKeys:
      "F11": (cm)->
        cm.setOption("fullScreen", !cm.getOption("fullScreen"))
      "Esc": (cm)->
        if cm.getOption("fullScreen") then cm.setOption("fullScreen", false)

  Restangular.all('resources').getList().then (templatable_types)->
    $scope.templatable_types = templatable_types

  Restangular.all('templates').getList().then (templates)->
    $scope.templates = templates
  $scope.store = Restangular.all('pages')

  Restangular.all('users').customGET('gcms_user').then (current_user) ->
    $scope.currentUser = current_user
    $scope.currentUser.admin = $scope.currentUser.role == 'admin'

  $scope.exceptCurrentPage = (pages) ->
    new_pages = []
    for p in pages
      new_pages.push(p) if p.id != parseInt($stateParams.id)
    new_pages

  if $stateParams.id
    $scope.store.get($stateParams.id).then (page)->
      $scope.page = page
  else
    $scope.page = {}

  build_parent_pages = (pages, depth) ->
    str = ""
    i=0
    while i < depth
      str = str+ '-'
      i++
    options = []
    angular.forEach(pages, (value, key) ->
      options.push({id: value.id, title: str+value.title})
      if value.children.length > 0
        options = options.concat(build_parent_pages(value.children, depth+1)))
    return options


  $scope.store.getList().then (pages)->
    $scope.pages = pages
    $scope.parentPages = build_parent_pages(pages, 0)
    if $stateParams.id
      $scope.pages = $scope.exceptCurrentPage($scope.pages)
      $scope.parentPages = $scope.exceptCurrentPage($scope.parentPages)
    $scope.page.slug = "index" if $scope.pages.length == 0
    unless $scope.page.parent_id
      index_page = _.select($scope.pages, (p) -> p.slug == 'index')[0]
      $scope.page.parent_id = (if index_page then index_page.id else null)


  $scope.create = ->
    $scope.store.post($scope.page).then ->
      $state.go('pages')
    ,(response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.update = ($event)->
    $scope.page.put().then ->
      if $event.target.attributes['data-redirect']
        $state.go('pages')
    ,(response)->
      Alertify.error(ErrorsService.prepareErrorsString(response.data.errors))

  $scope.destroy = (page)->
    if(confirm('Вы уверены?'))
      Restangular.restangularizeElement(null, page, 'pages').remove().then ->
        $scope.store.getList().then (pages)->
          $scope.pages = pages

  $scope.toggle = (scope) ->
    scope.toggle()

  $scope.treeOptions = {
      dropped: (event) ->
        Restangular.all('pages').customPOST(angular.toJson($scope.pages),'sorting')
        $scope.store.getList().then (pages) ->
          $scope.pages = pages
  }

angular.module('GCMS')
    .controller('PagesController', ['$scope', '$state', '$cookieStore', 'Restangular', '$stateParams', 'Alertify', 'ErrorsService', PagesController])
