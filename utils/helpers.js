function fn() {
  return {
    generateUser: function(password) {
      var username = 'qa_user_' + new Date().getTime();
      var encoded = java.util.Base64.getEncoder().encodeToString(password.getBytes());

      return {
        username: username,
        password: encoded
      };
    },

    signup: function(user) {
      return karate.call({
        url: 'https://api.demoblaze.com/signup',
        method: 'post',
        request: user
      });
    }
  };
}