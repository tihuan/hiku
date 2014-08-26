angular
  .module('Shoplist')
  .factory('Item', ['$resource', Item]);

function Item($resource) {
    var resource = $resource('/items/:id', { id: '@id' });
    var service = {
      all: all,
      create: create,
      remove: remove
    };

    return service;

    function all() {
      return resource.query();
    };

    function create(attr) {
      console.log(attr);
      return resource.save(attr);
    };

    function remove(itemId) {
      return resource.remove({ id: itemId });
    };
}
