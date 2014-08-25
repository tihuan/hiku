angular
  .module('Shoplist')
  .directive('itemList', itemList);

function itemList() {
  return {
    restrict: 'E',
    templateUrl: '/assets/item-list.html'
  };
}
