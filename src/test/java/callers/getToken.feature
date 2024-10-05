Feature: This feature file includes getting access token for requests...

  Background:
    * url 'https://giris.epias.com.tr/cas/v1/tickets'

  Scenario: Getting access token
    Given header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'text/plain'
    And request "username="+ username + "&password=" + password
    When method POST
    Then status 201
    And match response == '#string'