angular
  .module('Shoplist')
  .directive('itemForm', itemForm);

  function itemForm() {
    return {
      restrict: 'E',
      templateUrl: '/assets/item-form.html'
    };
  }
