app.controller('ItemsController', ['Item', function(Item) {
  this.items = Item.all();

  this.createItem = function() {
    var attr = {};
    attr.name = this.name;
    attr.quantity = this.quantity;
    var newItem = Item.create(attr);
    this.items.push(newItem);
    this.name = "";
    this.quantity = "";
  };

  this.deleteItem = function(id, index) {
    this.items.splice(index, 1);
    return Item.delete(id);
  };
}]);
