@Third-Party-Update
Feature: User should be able to get third-party update through APIs

  Background:
    * def setup = callonce read('classpath:features/ThreePM/ThirdPartyReportauthtoken.feature')
    * def accessToken = setup.accessToken
    * header Authorization = 'Bearer ' + accessToken
    * url baseURL

  # sameer 05/29/2019
  @IPI-883
  Scenario: User should be able to update company third party fields with risk factors and custom fields
    Given path "api/v1/thirdparty/company/update"
    And request read('classpath:testData/ThirdPartyCompanyUpdate.json')
    And header Content-Type = 'application/json'
    And method post
    Then status 200
    And match response contains '#string'

  # sameer 05/29/2019
  @IPI-883
  Scenario: User should be able to update individual third party fields with risk factors
    Given path "api/v1/thirdparty/individual/update"
    And request read('classpath:testData/ThirdPartyIndividual.json')
    And header Content-Type = 'application/json'
    And method post
    Then status 200
    And match response contains '#string'

  # sameer 05/29/2019
  @IPI-883
  Scenario: User should be able to update relationship status for company third party
    Given path "api/v1/thirdparty/company/update"
    And request read('classpath:testData/ThirdPartyRstatus.json')
    And header Content-Type = 'application/json'
    And method post
    Then status 200
    And match response contains '#string'
