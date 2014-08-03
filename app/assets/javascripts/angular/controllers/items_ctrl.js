app.controller('ItemsController', ['Item', '$rootScope', function(Item, $rootScope) {
  var itemsCtrl = this;
  this.items = function() {
    Item.all();
  }

  this.createItem = function() {
    var attr = {};
    attr.name = this.name;
    attr.quantity = this.quantity;
    itemsCtrl.items.push(attr);
    var newItem = Item.create(attr);
    newItem.$promise.then(
      function(success) {
        attr['id'] = newItem.data.id;
      }
      )
    this.name = "";
    this.quantity = "";
  };

  this.deleteItem = function(id, index) {
    this.items.splice(index, 1);
    return Item.delete(id);
  };

  $rootScope.$on('loggedIn', function() {
    itemsCtrl.items = Item.all();
  });
}]);
