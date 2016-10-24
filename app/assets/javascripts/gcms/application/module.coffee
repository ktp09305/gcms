angular.module('GCMS', ['ui.bootstrap', 'ui.router', 'ngCookies', 'restangular', 'templates', 'ui.tree', 'ui.codemirror', 'flow', 'ui.select', 'ngSanitize', 'ngCkeditor', 'toggle-switch', 'angular-loading-bar', 'angularjs-dropdown-multiselect', 'Alertify', 'xeditable', 'as.sortable'])

angular.module('GCMS').config ['$httpProvider', '$locationProvider', 'RestangularProvider', 'flowFactoryProvider', 'cfpLoadingBarProvider', ($httpProvider, $locationProvider, RestangularProvider, flowFactoryProvider, cfpLoadingBarProvider) ->
  cfpLoadingBarProvider.includeSpinner = false
  $locationProvider.html5Mode(true)
  $httpProvider.defaults.withCredentials = true

  RestangularProvider.setBaseUrl('/gcms')
  RestangularProvider.setRequestSuffix(".json")

  flowFactoryProvider.defaults =
    target: '/gcms/assets.json'
    permanentErrors: [404, 500, 501]
    maxChunkRetries: 1
    chunkSize: 50*1024*1024
    chunkRetryInterval: 5000
    simultaneousUploads: 4
    testChunks: false
    fileParameterName: "asset[file]"
]
  .run ['$http', '$cookies', 'editableOptions', '$rootScope', '$state', ($http, $cookies, editableOptions, $rootScope, $state) ->
    $rootScope.$state = $state
    $http.defaults.headers.common['X-XSRF-TOKEN'] = $cookies['XSRF-TOKEN']
    editableOptions.theme = 'bs3'
]
