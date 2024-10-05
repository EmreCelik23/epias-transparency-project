Feature: This feature file includes tests for Market Participants in EPIAS-Electricity-Service
  Background:
    * url 'https://seffaflik.epias.com.tr/electricity-service/v1/markets'
    * path 'general-data/data/market-participants'
    * def marketParticipantsReq = read('classpath:data/payloads/electricityService/marketParticipantsReq.json')
    * def marketParticipantsRes = read('classpath:data/schemas/electricityService/marketParticipantsRes.json')

  @smoke
  Scenario: Getting Data from Market Participants
    Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request {}
    When method POST
    Then status 200
    * match each response.items[*] == marketParticipantsRes

  @smoke
  Scenario: Getting Data from Market Participants w/ Page info
    Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request marketParticipantsReq
    When method POST
    Then status 200
    * match each response.items[*] == marketParticipantsRes