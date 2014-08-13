app.factory('Item', ['$resource', function($resource) {
  function Item() {
    this.service = $resource('/items/:id', { id: '@id' });
  };
  Item.prototype.all = function() {
    return this.service.query();
  };
  Item.prototype.create = function(attr) {
    console.log(attr);
    return this.service.save(attr);
  };
  Item.prototype.delete = function(itemId) {
    this.service.remove({ id: itemId });
  };
  return new Item;
}]);

app.directive('itemForm', function(){
  return {
    restrict: 'E',
    templateUrl: '/assets/item-form.html'
  };
});

app.directive('itemList', function(){
  return {
    restrict: 'E',
    templateUrl: '/assets/item-list.html'
  };
});
