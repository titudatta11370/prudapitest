@Third-Party
Feature: User should be able to interact with third-parties through APIs

  Background:

    * def setup = callonce read('classpath:features/ThreePM/ThreePMauthtoken.feature')
    * def accessToken = setup.accessToken
    * header Authorization = 'Bearer ' + accessToken
    * url baseURL


  Scenario: User ID that exist but do not have API permission should get 401
    Given path "/api/v1/thirdparty/147983"
    When method get
    Then status 401


  Scenario: User ID that does not exist in our system should get 404
    Given path "/api/v1/thirdparty/99999999"
    When method get
    Then status 404

  Scenario: Getting a third-party info
    Given path "/api/v1/thirdparty/151729"
    When method get
    Then status 200
    And print response

  Scenario: Getting second third-party info
    Given path "/api/v1/thirdparty/146379"
    When method get
    Then status 200
    And print response

  Scenario: Affiliates should return correct data
    Given path "/api/v1/thirdparty/144201"
    When method get
    Then status 200
    And print response
    And match response contains {affiliates:[{"name": "Roob Group","address": "211 Prohaska Well","city": "Daishaside","region": null,"postalCode": "08327","country": "Cambodia"}]}

  Scenario: Custom fields should return correct data
    Given path "/api/v1/thirdparty/144397"
    When method get
    Then status 200
    And print response
    And match response contains {"customFields": [{"name":"Last 4 SSN","value":[]},{"name":"Date CF","value":[]},{"name":"Multiselect","value":[]},{"name":"CustomField View Only","value":[]},{"name":"Brightline Manager Text Field","value":[]},{"name":"Custom Industry","value":[]},{"name":"MultiSelect Dropdown test","value":[]}]}


#    this client is "CYOA Workflow Test account"
  Scenario: Get third party report
    Given path "/api/v1/reports/thirdparties"
    And request {"clientId": 181,"pageNumber": 1}
    And header Content-Type = 'application/json'
    When method post
    Then status 200

  # sameer 01/04/2019
  @IPI-750
  Scenario: In third parties report, verify new data points added correctly: Third Party CreatedDate, LastModifiedDate,
  CreatedBy [email], ModifiedBy [email], InsightScore [integer] fields are also included
    Given path "/api/v1/reports/thirdparties"
    And request {"clientId": 289,"pageNumber": 1}
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And match each response[*].dateCreated == '#string'
    And match each response[*].lastModifiedDate == '#string'
    And match each response[*].createdBy == '#string'
    And match each response[*].InsightScore == '#string'
    And match each response[*].modifiedBy == '#string'

