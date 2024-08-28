Feature: TC-NEF-BAT-0101_Event_Exposure

  Scenario: AP-Event-Exposure-Single-UE-POST
    Given target type is NEF_HTTP
    Given action name is SUBSCRIBE
    Given path is /3gpp-monitoring-event/v1/EventMonitorApId/subscriptions
    Given request header is Content-Type:application/json
    Given request content is
    """
      {
        "supportedFeatures": "4",
        "externalId": "99000000@5gc.ericsson.com",
        "notificationDestination": "http://pcf-simulator-service:80/npcf-policyauthorization/",
        "monitoringType": "LOCATION_REPORTING",
        "monitorExpireTime": "2028-01-31T00:15:00+08:00",
        "maximumNumberOfReports": 10,
        "locationType": "CURRENT_LOCATION",
        "accuracy": "TA_RA"
     }
    """
    When we send POST request
    Then we expect response status code 201
    Then we expect response time less than 20000 milliseconds
