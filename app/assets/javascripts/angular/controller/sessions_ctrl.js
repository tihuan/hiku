app.controller('SessionsController', ['$http', 'Session', function($http, Session) {
  this.loggedIn = false;
  this.error = false;
  this.invalid = false;
  this.login = function() {
    var sessionCtrl = this;
    var attr = {};
    attr.email = this.email;
    attr.password = this.password;
    var request = Session.create(attr);
    request.$promise.then(
      // success
      function(resp) {
        console.log(resp);
        sessionCtrl.loggedIn = true;
      },
      // error
      function(error) {
        console.log(error);
        sessionCtrl.errorMsg = error.data;
        sessionCtrl.error = true;
      }
    )
  };
}]);
