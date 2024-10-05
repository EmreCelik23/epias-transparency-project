Feature: This feature file includes tests for Daily Actualization Amount in EPIAS-Natural-Gas-Service

  Background:
    * url 'https://seffaflik.epias.com.tr/natural-gas-service/v1/transmission'
    * def daaReq = read('classpath:data/payloads/naturalGas/daaReq.json')
    * def daaRes = read('classpath:data/schemas/naturalGas/daaRes.json')
    * configure connectTimeout = 60000
    * configure readTimeout = 60000

  @util @smoke
  Scenario: Getting Data from DAA
    Given path 'data/daily-actualization-amount'
    And headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request daaReq.list
    When method POST
    Then status 200
    And match each response.items[*] == daaRes.list

  @smoke
  Scenario: Exporting Data from DAA w/ XLSX format
    Given path 'export/daily-actualization-amount'
    And headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    And request daaReq.export
    When method POST
    Then status 200
    And match response == '#present'

  @smoke
  Scenario: Exporting Data from DAA w/ CSV format
    Given path 'export/daily-actualization-amount'
    And headers {TGT: '#(tgt)', Content-Type: 'application/json'}
    * daaReq.export.exportType = "CSV"
    * def javaUtils = Java.type('helpers.javaUtils')

    And request daaReq.export
    When method POST
    Then status 200

    * csv jsonResponse = javaUtils.csvFormatter(response)
    * def comparingItems = karate.call('@util').response.items
    * print jsonResponse
    * print comparingItems

    * def func =
    """
      function(i){
        formattedDate = javaUtils.changeDateFormat(comparingItems[i].date, "dd.MM.yyyy");
        if(jsonResponse[i]["Gaz Günü"] == formattedDate)
          console.log("Eşit " + formattedDate);

        if(javaUtils.integerFormatter(jsonResponse[i]["Günlük Enjeksiyon Gerçekleşmesi (Sm3)"]) == comparingItems[i].injection)
          console.log("Eşit");
      }
    """

    * karate.repeat(jsonResponse.length, func)

    #And match each jsonResponse[*] == javaUtils.dateFormatter(comparingItems[*])
    #And match each javaUtils.integerFormatter(jsonResponse[*]["Günlük Enjeksiyon Gerçekleşmesi (Sm3)"]) == comparingItems[*].injection



