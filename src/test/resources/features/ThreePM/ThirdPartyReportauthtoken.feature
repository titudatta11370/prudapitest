Feature: Auth Token

  @ignore
  Scenario: Auth token
    Given url 'https://insightauthqa.exiger.com/oauth2/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'application/json'

    * form field grant_type = 'password'
    * form field username = 'api_insight@brightline.com'
    * form field password = 'Password123!'
    * method post
    * status 200
    * def accessToken = response.access_token