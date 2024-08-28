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

  Scenario: GET Request
    Given target type is NEF_HTTP
    Given action name is GET_ONE
    Given path is /3gpp-chargeable-party/v1/af111/transactions/<SubscriptionId>
    Given request header is Content-Type:application/json
    When we send GET request
    Then we expect response status code 200
    Then we expect response time less than 2000 milliseconds

  Scenario: Update Request
    Given target type is NEF_HTTP
    Given action name is PATCH
    Given path is /3gpp-chargeable-party/v1/af111/transactions/<SubscriptionId>
    Given request header is Content-Type:application/merge-patch+json
    Given request content is
    """
    {"usageThreshold": {"duration": 2147483647,"downlinkVolume": 2147483647, "uplinkVolume": 2147483647, "totalVolume": 9223372036854775807}, "flowInfo": [{"flowDescriptions": ["in 10.10.20.1 132.120.31.1 tcp 2000 80", "out 10.10.30.1 132.120.32.1 tcp 3000 80"], "flowId": 1}], "referenceId": "123456789", "sponsoringEnabled": true}
    """
    When we send PATCH request
    Then we expect response status code 200
    Then we expect response time less than 2000 milliseconds




  Scenario: DELETE 
    Given action name is UNSUBSCRIBE
    Given target type is NEF_HTTP
    Given path is /3gpp-chargeable-party/v1/af111/transactions/<SubscriptionId>
    When we send DELETE request
    Then we expect response status code 204
    Then we expect response time less than 2000 milliseconds

