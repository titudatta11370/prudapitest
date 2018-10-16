Feature: Old API data should be returned

  Background:
    * header Authorization = call read('basic-auth.js') { username: 'z8trstp', password: 'skg6grp0' }

  Scenario: All the plans should be returned
    Given path 'plan'
    When method get
    Then  status 200
    And print response

