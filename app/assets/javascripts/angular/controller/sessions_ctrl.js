app.controller('SessionsController', ['$http', 'Session', '$window', function($http, Session, $window) {
  this.loggedIn = false;
  this.error = false;
  this.login = function() {
    var sessionCtrl = this;
    var attr = {};
    attr.email = this.email;
    attr.password = this.password;
    var request = Session.create(attr);
    request.$promise.then(
      // success
      function(success) {
        $window.sessionStorage.token = success.data;
        console.log($window.sessionStorage.token);
        sessionCtrl.loggedIn = true;
      },
      // error
      function(error) {
        sessionCtrl.errorMsg = error.data;
        delete $window.sessionStorage.token;
        sessionCtrl.error = true;
      }
    )
  };
}]);
