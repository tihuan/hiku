app.controller('SessionsController', ['$http', 'Session', function($http, Session) {
  this.loggedIn = false;
  this.error = false;
  this.login = function() {
    console.log("called!");
    console.log(this);
    var sessionCtrl = this;
    var attr = {};
    attr.email = this.email;
    attr.password = this.password;
    var request = Session.create(attr);
    request.$promise.then(
      // success
      function(resp) {
        sessionCtrl.loggedIn = true;
      },
      // error
      function(error) {
        sessionCtrl.error = true;
      }
    )
  };
}]);
