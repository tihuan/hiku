app.controller('ItemsController', ['Item', '$rootScope', function(Item, $rootScope) {
  var itemsCtrl = this;
  this.items = [];

  this.createItem = function() {
    var attr = {};
    attr.name = this.name.titleize();
    attr.quantity = this.quantity;
    itemMatch(attr);
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

  function itemMatch(attr) {
    var matched = false;
    _.map(itemsCtrl.items, function(item) {
      if (item.name.titleize() === attr.name.titleize()) {
        matched = true;
        return item.quantity = item.quantity + attr.quantity;
      }
    });
    if (matched === false) {
      return itemsCtrl.items.push(attr);
    }
  }

  $rootScope.$on('loggedIn', function() {
    itemsCtrl.items = Item.all();
  });

  $rootScope.$emit('checkToken');
}]);


