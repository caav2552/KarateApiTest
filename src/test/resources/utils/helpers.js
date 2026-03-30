function fn() {
  return {
    generateUser: function(password) {
      var timestamp = new Date().getTime();
      var encoded = java.util.Base64.getEncoder().encodeToString(password.getBytes());
      
      return {
        username: 'user_' + timestamp,
        password: encoded
      };
    }
  };
}