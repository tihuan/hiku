app.controller('SessionsController', ['$http', 'Session', 'Item', '$window', function($http, Session, Item, $window) {
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
        Item.all();
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
