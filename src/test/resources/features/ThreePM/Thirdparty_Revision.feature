Feature: API should return a 3p edited revisions

  Background:
    * def setup = callonce read('classpath:features/ThreePM/Thirdparty_revision_token.feature')
    * def accessToken = setup.accessToken
    * def basePath = "https://revision-historystaging.exiger.com/api/v1/"
    * header Authorization = 'Bearer ' + accessToken

  # sameer 01/04/2019
  @IPI-456
  Scenario: Edited 3p details would be visible through an API
    Given url basePath+'saverevision'
    And request read('classpath:testData/revision_request.json')
    And header Content-Type = 'application/json'
    And method post
    Then status 200
    And print response
    And match response == {"RevisionId":#number,"ReferenceId":#number,"DateCreated":'#string',"ApplicationNamespace":'#string'}
    * match response.ReferenceId == 200616

  # sameer 01/04/2019
  @IPI-456
  Scenario: Get full revision history details through an API after providing revision id
    Given url basePath+'getrevisionjson'
    And param RevisionId = 3981
    And header Content-Type = 'application/json'
    And header Cache-Control = 'no-cache'
    And method get
    Then status 200
    And print response

  # sameer 01/04/2019
  @IPI-456
  Scenario: Get Revision history difference through an API after providing two revisions for same third party
    Given url basePath+'getrevisiondiff'
    And param RevisionIdA = 3981
    And param RevisionIdB = 3978
    And header Content-Type = 'application/json'
    And header Cache-Control = 'no-cache'
    And method get
    Then status 200
    And print response

  # sameer 01/04/2019
  @IPI-456
  Scenario Outline: Get third party revision through an API after creation of third party
    Given url basePath+'getrevisiondetailslist'
    And param ApplicationNamespace = 'ThirdParty.Details'
    And param ReferenceId = <refid>
    And header Content-Type = 'application/json'
    And header Cache-Control = 'no-cache'
    And method get
    Then status 200
    And print response
    And match each response == { RevisionId: '#number', Reason: '#string',DateCreated: '#string', ApplicationNamespace:'#string',CreatedBy:'#string',ReferenceId:'#number',JSONContent:null}
    * def expectedresponsereason = '<reason>'
    And match each response[*].Reason[*] contains '<reason>'

    Examples:
      | activity                                  | refid  | reason                          |
      | Create third party                        | 201122 | Create                          |
      | batch upload                              | 200905 | CreateFromBatchUpload           |
      | Create TP via API                         | 201230 | Create                          |
      | update Third party                        | 201228 | UpdateCoreDetails               |
      | Two-Way Link from Risk Factors            | 201235 | Create                          |
      | Questionnaire                             | 200601 | UpdateCustomFieldsFromQualtrics |
      | Questionnaire+DDIQ                        | 201238 | UpdateCustomFieldsFromQualtrics |
      | CQM Questionnaire                         | 201242 | UpdateCustomFieldsFromCQM       |
      | CQM Questionnaire+DDIQ)                   | 201239 | UpdateCustomFieldsFromCQM       |
      | Updates from Master Affiliate (Manual UI) | 201246 | UpdateFromMasterAffiliate       |








