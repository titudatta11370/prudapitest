function fn() {
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'qa'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
    baseURL: 'https://insightapi.exiger.com',
    cqmBaseURL : 'https://surveyapi.exiger.com',
    userName : '',
    passWord : ''
  };
  if (env == 'stage') {
    // over-ride only those that need to be
    config.baseURL = 'https://ddiq-stage.outsideiq.com';
    config.userName = 'clarity_3';
    config.passWord = 'VQiwe2534!';



  } else if (env == 'qa') {
    config.baseURL = 'https://insightapiqa.exiger.com';
    config.cqmBaseURL = 'https://surveyapiqa.exiger.com';

  }
  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 15000);

  return config;
}