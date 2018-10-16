function envSwitching() {
    var env = karate.env; // get java system property 'karate.env'
    karate.log('karate.env system property was:', env);
    if (!env) {
        env = 'qa'; // a custom 'intelligent' default
    }
    var config = { // base config JSON
        appId: 'my.app.id',
        appSecret: 'my.secret',
        baseURL: 'https://retirementesb-qa.prudential.com'
    };
    if (env == 'qa') {
        config.baseURL = 'https://retirementesb-qa.prudential.com';
    } else if (env == 'qa3') {
        config.baseURL = 'https://retirementesb3-qa.prudential.com';
    }
    // if server doesnt respond withing 5 secs
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);
    return config;
}