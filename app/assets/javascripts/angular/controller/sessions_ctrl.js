app.controller('SessionsController', ['$http', 'Session', 'Item', '$window', function($http, Session, Item, $window) {
  this.loggedIn = $window.sessionStorage.token;
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
        clearInput(attr);
      },
      // error
      function(error) {
        sessionCtrl.errorMsg = error.data;
        delete $window.sessionStorage.token;
        sessionCtrl.error = true;
        clearInput(attr);
      }
    )
  };

  function clearInput(attr) {
    attr.email = "";
    attr.password = "";
  }
}]);
