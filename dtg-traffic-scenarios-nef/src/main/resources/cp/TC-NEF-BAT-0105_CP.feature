Feature: TC-NEF-BAT-0104_CharageableParty

  Scenario: POST
    Given target type is NEF_HTTP
    Given action name is SUBSCRIBE
    Given path is /3gpp-chargeable-party/v1/af111/transactions/
    Given request header is Content-Type:application/json
    Given request content is
      """
      { "notificationDestination": "http://nef-cp-sim:80", "ipv4Addr": "10.10.10.1", "flowInfo": [ { "flowDescriptions": [ "in 10.10.20.1 132.120.21.1 http2 2000 80", "out 10.10.30.1 132.120.22.1 http2 3000 80" ], "flowId": 0 } ], "sponsorInformation": { "sponsorId": "BDT_SPONSOR_1", "aspId": "ASP1" }, "sponsoringEnabled": true, "supportedFeatures": "0" }

      """
    When we send POST request
    Then we expect response status code 201
    Then we expect response time less than 2000 milliseconds
    Then compute SubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm


  Scenario: Notification
    Given target type is NEF_HTTP
    Given action name is NOTIFY
    Given path is /cp/pcf/v1/101/<SubscriptionId>/notify
    Given request header is Content-Type:application/json
    Given request content is
    """
    {"evNotifs": [{"event": "USAGE_REPORT"}], "usgRep": {"duration": 10, "totalVolume": 100000}, "evSubsUri": "http://pcfsubresource/0001"}
    """
    When we send POST request
    Then we expect response status code 204


  Scenario: DELETE 
    Given action name is UNSUBSCRIBE
    Given target type is NEF_HTTP
    Given path is /3gpp-chargeable-party/v1/af111/transactions/<SubscriptionId>
    When we send DELETE request
    Then we expect response status code 204
    Then we expect response time less than 2000 milliseconds

