angular
  .module('Shoplist')
  .controller('ItemsController', ['Item', '$rootScope', ItemsController]);

function ItemsController(Item, $rootScope) {
  var itemsCtrl = this;

  itemsCtrl.items = [];
  itemsCtrl.createItem = createItem;
  itemsCtrl.deleteItem = deleteItem;

  function createItem() {
    var attr = {};
    attr.name = this.name.titleize();
    attr.quantity = this.quantity || 1;
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

  function deleteItem(id, index) {
    this.items.splice(index, 1);
    return Item.remove(id);
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
  };

  $rootScope.$on('loggedIn', function() {
    itemsCtrl.items = Item.all();
  });

  $rootScope.$emit('checkToken');
};
