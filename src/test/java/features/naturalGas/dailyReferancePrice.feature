Feature: This feature file includes tests for Daily Reference Price in EPIAS-Natural-Gas-Service

  Background:
    * url 'https://seffaflik.epias.com.tr/natural-gas-service/v1/markets'
    * path 'sgp/data/daily-reference-price'
    * def drpReq = read('classpath:data/payloads/naturalGas/drpReq.json')
    * def drpRes = read('classpath:data/schemas/naturalGas/drpRes.json')
    * configure connectTimeout = 60000
    * configure readTimeout = 60000

  @smoke
  Scenario: Getting Data from DRP
    Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request drpReq.list
    When method POST
    Then status 200
    And match each response.items[*] == drpRes.list

  @negative
  Scenario: Getting Data from DRP w/ start-date is later than end-date
    Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    * drpReq.list.startDate = "2024-09-09T00:00:00+03:00"
    * drpReq.list.endDate = "2024-08-05T00:00:00+03:00"
    And request drpReq.list
    When method POST
    Then status 400
    And match response.errors[0].errorMessage == '#regex ^İstekeki başlangıç tarihi\\(.{28}\\) bitiş tarihinden\\(.{28}\\) sonra olamaz!$'

  #@negative
  #Scenario: Getting Data from DRP w/ end-date later than the present date
  #  Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
  #  * drpReq.list.startDate = "2024-09-06T00:00:00+03:00"
  #  * drpReq.list.endDate = "2024-09-07T00:00:00+03:00"
  #  And request drpReq.list
  #  When method POST
  #  Then status 400
  #  And match response.errors[0].errorMessage == '#regex ^İstekeki başlangıç tarihi\\(.{28}\\) bitiş tarihinden\\(.{28}\\) sonra olamaz!$'

