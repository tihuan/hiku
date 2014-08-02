app.factory('Item', ['$resource', function($resource){
  function Item() {
    this.service = $resource('/items/:id', { id: '@id' });
  };
  Item.prototype.all = function() {
    return this.service.query();
  };
  return new Item;
}]);
