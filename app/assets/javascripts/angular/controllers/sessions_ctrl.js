app.controller('SessionsController', ['$http', 'Session', 'Item', '$rootScope', '$window', function($http, Session, Item, $rootScope, $window) {
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
        $rootScope.$emit('loggedIn');
        sessionCtrl.loggedIn = true;
        sessionCtrl.error = false;
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
  this.logout = function() {
    delete $window.sessionStorage.token;
    $window.location.reload();
  };

  function clearInput(attr) {
    attr.email = "";
    attr.password = "";
  }
}]);
