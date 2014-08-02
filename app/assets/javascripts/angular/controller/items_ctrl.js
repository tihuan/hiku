app.controller('ItemsController', ['Item', function(Item) {
  this.items = Item.all();
  this.deleteItem = function(id, index) {
    this.items.splice(index, 1);
    return Item.delete(id);
  };
}]);
