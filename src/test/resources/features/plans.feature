Feature: User should be able to get the plan info

  Background:
    * header Authorization = call read('basic-auth.js') { username: 'z8trstp', password: 'skg6grp0' }


  Scenario: All the plans should be returned
    Given path 'plan'
    When method get
    Then  status 200
    And print response

  Scenario: The plans should return withing 250 ms
    Given path 'plan'
    When method get
    Then assert responseTime < 250



