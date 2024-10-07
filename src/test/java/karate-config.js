 function karateConfig() {
  var config = {
    tgt: karate.callSingle('classpath:callers/getToken.feature',
        {username: "temrecelik@epias.com.tr", password: "Test1234."}).response
  };
  return config;
}
