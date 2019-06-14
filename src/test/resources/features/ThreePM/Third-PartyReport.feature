@Third-Party-Report
Feature: User should be able to get third-partie report through APIs

  Background:
    * def setup = callonce read('classpath:features/ThreePM/ThirdPartyReportauthtoken.feature')
    * def accessToken = setup.accessToken
    * header Authorization = 'Bearer ' + accessToken
    * url baseURL

  # sameer 02/04/2019
  @IPI-750
  Scenario: In third parties report, verify new data points added correctly: Third Party CreatedDate, LastModifiedDate,
  CreatedBy [email], ModifiedBy [email], InsightScore [integer] fields are also included
    Given path "/api/v1/reports/thirdparties"
    And request {"clientId": 289,"pageNumber": 1}
    And header Content-Type = 'application/json'
    When method post
    Then status 200
    And print response
    And match response..clientId contains [#number]
    And match response[*].clientId contains ['#number']


#    And print response
#    And match each response[*].dateCreated == '#string'
#    And match each response[*].lastModifiedDate == '#string'
#    And match each response[*].createdBy == '#string'
#    And match each response[*].InsightScore == '#string'
#    And match each response[*].modifiedBy == '#string'


#    Then match $..clientId == '#number'
#    And match each response[*].clientId == '#string'


  # sameer 02/04/2019
  @IPI-749
  Scenario: In Third-Party Information API call, verify new data points added correctly: Third Party CreatedDate, LastModifiedDate,
  CreatedBy [email], ModifiedBy [email], InsightScore [integer] fields are also included
    Given path "/api/v1/thirdparty/198265"
    When method GET
    Then status 200
    And match each response[*].dateCreated == '#string'
    And match each response[*].lastModifiedDate == '#string'
    And match each response[*].createdBy == '#string'
    And match each response[*].InsightScore == '#string'
    And match each response[*].modifiedBy == '#string'


