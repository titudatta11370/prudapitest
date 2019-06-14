@CQM
Feature: Test CQM APIs

  Background:
    * def setup = callonce read('classpath:features/CQM/CQMAuth.feature')
    * def accessToken = setup.accessToken
    * header Authorization = 'Bearer ' + accessToken
    * url cqmBaseURL


  Scenario: User should be able to get questionnaire definitions
    Given path "/api/v1/questionnaires/getquestionnairedefinitions"
    When method get
    Then status 200
    And print response


#The ID in this scenario can be taken from
# (https://surveyapiqa.exiger.com/api/v1/questionnaires/createquestionnaireinstance)
  Scenario: User should be able to get questionnaire response
    Given path "/api/v1/questionnaires/getquestionnaireresponse/144943"
    When method get
    Then status 200
    And print response

  #this scenario needed a child question to be added through form data
  Scenario: Questionnaire response should have correct order of child question
    Given path "/api/v1/questionnaires/getquestionnaireresponse/151759"
    When method get
    Then status 200
    And print response

  Scenario: User should be able to get create questionnaire instance
    Given path "/api/v1/questionnaires/createquestionnaireinstance"
    Given request read('classpath:testData/CreateQuestionnaireInstance.json')
    When method post
    Then status 200

  Scenario: GetQuestionnaireDefinitions API call should return available survey languages
    Given path "/api/v1/questionnaires/getquestionnairedefinitions"
    When method get
    Then status 200
    And match response contains {"Id": 24,"QuestionnaireName": "Bryan 5-1 Localized","Languages": ["en","pl"]}

  Scenario: The auto-login link should be present when questionnaire is sent to a recipient
    Given path "/api/v1/questionnaires/createquestionnaireinstance"
    Given request read('classpath:testData/CreateQuestionnaireInstance.json')
    When method post
    Then status 200
    And print response
    * match response.UserSurveyUrl == '#string'

  Scenario: API response should have "Completed By" when the questionnaire is in completed state
    Given path "/api/v1/questionnaires/getquestionnaireresponse/144758"
    When method get
    Then status 200
    And print response
    Then match response.CompletedBy == 'michael@bluth.com'


  Scenario: A Document question should have a question type ID = 10
    Given path "/api/v1/questionnaires/getquestionnaireresponse/144948"
    When method get
    Then status 200
    And print response
    Then match $..QuestionTypeId == [10]



#    For this scenario, I created another questionnaire for another client and copied the questionnaire ID
  Scenario: User should NOT be able to get questionnaire response from another client
    Given path "/api/v1/questionnaires/getquestionnaireresponse/968"
    When method get
    Then status 500
    And print response


  Scenario: User should be able to add a recipient
    Given path "/api/v1/questionnaires/addrecipient"
    Given request read('classpath:testData/addRecipient.json')
    When method post
    Then status 200
#    And print response
    And def repientID = response




  Scenario: User should be able to download document doc using API
#    Given url "https://surveyapiqa.exiger.com/api/v1/questionnaires/getquestionnaireresponse/325"
#    When method get
#    Then status 200
#    * def docID = $..DocumentId
#    And print docID[0]

    Given path "/api/v1/documents/ed817fa7-7884-48d2-b626-1b15433f064b"
    When method get
    Then status 200
    And print response


  @ignore
  Scenario: User should be able to delete a recipient

    * def instanceID = 1007

    Given path "/api/v1/questionnaires/deleterecipient"
#    And request ({ RecipientUserId: [repientID], QuestionnaireInstanceId: '#(instanceID)' }
    And request ({ RecipientUserId: 5, QuestionnaireInstanceId: 1007})
    And method post
    Then status 200
    And print response


  Scenario: Edit Questionnaire Recipient should allow editing email address and username

    * def recipient =
      """
      {
        "RecipientUserId": 5,
        "RecipientFirstName": "Test",
        "RecipientLastName": "Test",
        "RecipientEmail": "michael@bluth.com"
      }
      """

    Given path "/api/v1/questionnaires/editrecipient"
    And request recipient
    When method post
    Then status 200
    And print response

