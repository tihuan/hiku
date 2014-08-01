app.controller('ItemsController', ['$resource', function($resource) {

  var Items = $resource('/items');
  this.items = Items.query();
}]);
