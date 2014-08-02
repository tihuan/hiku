app.factory('Item', ['$resource', function($resource) {
  function Item() {
    this.service = $resource('/items/:id', { id: '@id' });
  };
  Item.prototype.all = function() {
    return this.service.query();
  };
  Item.prototype.create = function(attr) {
    return this.service.save(attr);
  };
  Item.prototype.delete = function(itemId) {
    this.service.remove({ id: itemId });
  };
  return new Item;
}]);
