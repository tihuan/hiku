var app = angular.module("Shoplist", ['ngResource', 'ngRoute', 'ui.bootstrap']);

app.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);
