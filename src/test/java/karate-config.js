 function karateConfig() {
  var config = {
    tgt: karate.callSingle('classpath:callers/getToken.feature',
        {username: "temrecelik@epias.com.tr", password: "Cavaliers2016."}).response
  };
  return config;
}