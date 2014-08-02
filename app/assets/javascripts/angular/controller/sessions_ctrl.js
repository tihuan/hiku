app.controller('SessionsController', function() {
  this.loggedIn = false;

  this.login = function() {
    console.log("called!");
    this.loggedIn = true;
  };
});
