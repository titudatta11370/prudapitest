@CreateThirdParty
Feature: Test APIs to create thirdParty

  Background:
    * def setup = callonce read('classpath:features/ThreePM/ThreePMauthtoken.feature')
    * def accessToken = setup.accessToken
    * header Authorization = 'Bearer ' + accessToken
    * url "https://insightapiqa.exiger.com/api/v1/thirdparty/company"
  
   @bug
  Scenario: User should be able to create a thirdparty
    Given request read('classpath:testData/createThirdParty.json')
    When method post
    Then status 200


