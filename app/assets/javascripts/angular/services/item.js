app.factory('Item', ['$resource', function($resource) {
  function Item() {
    this.service = $resource('/items/:id', { id: '@id' });
  };
  Item.prototype.all = function() {
    return this.service.query();
  };
  Item.prototype.delete = function(itemId) {
    this.service.remove({ id: itemId });
  };
  return new Item;
}]);
