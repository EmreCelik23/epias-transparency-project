 function karateConfig() {
  var config = {
    tgt: karate.callSingle('classpath:callers/getToken.feature',
        {username: "abc", password: "***"}).response
  };
  return config;
}
