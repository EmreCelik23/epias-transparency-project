Feature: This feature file includes tests for PFK in EPIAS-Electricity-Service
  Background:
    * url 'https://seffaflik.epias.com.tr/electricity-service/v1/markets'
    * path 'ancillary-services/data/primary-frequency-capacity-price'
    * def pfkReq =  read('classpath:data/payloads/electricityService/pfkReq.json')
    * def pfkRes = read('classpath:data/schemas/electricityService/pfkRes.json')

  @smoke
  Scenario: Getting Data from PFK
    * delete pfkReq.page
    Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request pfkReq
    When method POST
    Then status 200
    * match each response.items[*] == pfkRes

  @negative
  Scenario: Getting Data from PFK w/o start-date info
    * pfkReq.startDate = null
    Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request pfkReq
    When method POST
    Then status 400
    And match response.errors[0].errorMessage == "`startDate` alanı boş olamaz!"

  @negative
  Scenario: Getting Data from PFK w/o start-date info
    * pfkReq.endDate = null
    Given headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request pfkReq
    When method POST
    Then status 400
    And match response.errors[0].errorMessage == "`endDate` alanı boş olamaz!"

