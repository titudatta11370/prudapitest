@MISC
Feature: Misc features

  Background:

    * def setup = callonce read('classpath:features/ThreePM/ThreePMauthtoken.feature')
    * def accessToken = setup.accessToken
    * url baseURL

  Scenario: Forged token should get a 404 response
    * header Authorization = 'Bearer ' + accessToken + 09876
    Given path "/api/thirdpartyinfo/v1/144201"
    When method get
    Then status 404


#
#  Scenario: Expired token should not work
#
#  Scenario: Different environment tokens should not work