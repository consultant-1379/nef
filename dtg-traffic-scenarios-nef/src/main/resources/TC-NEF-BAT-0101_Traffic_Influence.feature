Feature: TC-NEF-BAT-0101_Traffic_Influence

  Scenario: AP-TrafficInfluence-Single-UE-POST-Prepare
    Given target type is NEF_HTTP
    Given action name is SUBSCRIBE
    Given path is /3gpp-traffic-influence/v1/101/subscriptions
    Given request header is Content-Type:application/json
    Given request content is
      """
      {
          "trafficRoutes": [
              {
                  "routingProfileId": 1,
                  "dnai": "1"
              }
          ],
          "validGeoZoneIds": [
              "CN"
          ],
          "ipv4Addr": "10.10.10.1"
      }
      """
    When we send POST request
    Then we expect response status code 201
    Then we expect response time less than 20000 milliseconds
    Then compute SubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm

#  Scenario: GET Request
#    Given target type is NEF_HTTP
#    Given action name is GET_ONE
#    Given path is /3gpp-traffic-influence/v1/101/subscriptions/<SubscriptionId>
#    Given request header is Content-Type:application/json
#    When we send GET request
#    Then we expect response status code 200
#    Then we expect response time less than 20000 milliseconds

  Scenario: DELETE EvEx Change of SUPI
    Given action name is UNSUBSCRIBE
    Given target type is NEF_HTTP
    Given path is /3gpp-traffic-influence/v1/101/subscriptions/<SubscriptionId>
    When we send DELETE request
    Then we expect response status code 204



