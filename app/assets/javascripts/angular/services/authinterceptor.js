app.factory('authInterceptor', function($rootScope, $q, $window) {
  return {
    request: function(config) {
      config.headers = config.headers || {};
      if ($window.sessionStorage.token) {
        config.headers['hiku_token'] = $window.sessionStorage.token;
      }
      return config;
    },
    response: function(response) {
      if (response.status === 401) {
        // send user back to homepage if unauthorized
        $location.path('/');
      }
      return response || $q.when(response);
    }
  };
});

app.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.interceptors.push('authInterceptor');
  }
]);
