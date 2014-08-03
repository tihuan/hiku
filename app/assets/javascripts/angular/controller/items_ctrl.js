app.controller('ItemsController', ['Item', function(Item) {
  this.items = Item.all();

  this.createItem = function() {
    var itemsCtrl = this;
    var attr = {};
    attr.name = this.name;
    attr.quantity = this.quantity;
    var newItem = Item.create(attr);
    itemsCtrl.items.push(newItem);
    newItem.$promise.then(
      function(success) {
        var all_items = itemsCtrl.items;
        var item_created = all_items[all_items.length-1];
        item_created['id'] = item_created.data.id;
      }
      )
    this.name = "";
    this.quantity = "";
  };

  this.deleteItem = function(id, index) {
    this.items.splice(index, 1);
    return Item.delete(id);
  };
}]);
