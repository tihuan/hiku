app.factory('Item', ['$resource', function($resource) {
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

    function create() {
      console.log(attr);
      return resource.save(attr);
    };

    function remove() {
      return resource.remove({ id: itemId });
    };
}]);
