Feature: Test for basic authorization

  Scenario: Invalid auth should return a 404
    Given header Authorization = call read('basic-auth.js') { username: 'fail', password: 'fail' }
    When method get
    Then status 404

  Scenario: Invalid string/combination of strings should return 404
    Given header Authorization = call read('basic-auth.js') { username: 'z8trstp', password: 'Shweriruiu9809708723' }
    When method get
    Then status 404
