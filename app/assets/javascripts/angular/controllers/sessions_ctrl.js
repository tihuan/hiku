app.controller('SessionsController', ['$http', 'Session', 'Item', '$rootScope', '$window', function($http, Session, Item, $rootScope, $window) {
  var sessionCtrl = this;
  this.loggedIn = $window.sessionStorage.token;
  this.error = false;

  this.login = function() {
    var attr = {};
    attr.email = this.email;
    attr.password = this.password;
    var request = Session.create(attr);
    request.$promise.then(
      // success
      function(success) {
        $window.sessionStorage.token = success.data;
        // Showing token in CONSOLE.LOG
        console.log($window.sessionStorage.token);
        sessionCtrl.loadItems();
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

  this.loadItems = function() {
    $rootScope.$emit('loggedIn');
    sessionCtrl.loggedIn = true;
    sessionCtrl.error = false;
  };

  this.logout = function() {
    delete $window.sessionStorage.token;
    sessionCtrl.refresh();
  };

  this.refresh = function() {
    $window.location.reload();
  }

  $rootScope.$on('checkToken', function() {
    if (sessionCtrl.loggedIn) {
      sessionCtrl.loggedIn = true;
      sessionCtrl.error = false;
      $rootScope.$emit('loggedIn');
    }
  });

  function clearInput(attr) {
    attr.email = "";
    attr.password = "";
  }
}]);
