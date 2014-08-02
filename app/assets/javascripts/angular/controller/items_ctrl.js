app.controller('ItemsController', ['Item', function(Item) {
  this.items = Item.all();
}]);
