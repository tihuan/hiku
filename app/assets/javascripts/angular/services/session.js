angular
  .module('Shoplist')
  .factory('Session', ['$resource', Session]);

function Session($resource) {
  function Session() {
    this.service = $resource('/sessions/:id', { id: '@id' });
  };
  Session.prototype.create = function(attr) {
    return this.service.save(attr);
  };
  Session.prototype.delete = function(token) {
    this.service.remove({ token: token });
  };
  return new Session;
}
