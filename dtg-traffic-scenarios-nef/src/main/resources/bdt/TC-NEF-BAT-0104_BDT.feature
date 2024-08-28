Feature: TC-NEF-BAT-0101_Traffic_Influence

  Scenario: BDT-Single-UE-POST-Prepare
    Given target type is NEF_HTTP
    Given action name is SUBSCRIBE
    Given path is /3gpp-bdt/v1/af111/subscriptions/
    Given request header is Content-Type:application/json
    Given request content is
      """
{
	"numberOfUEs": 500, 
	"desiredTimeWindow": 
		{
			"startTime": "2019-08-10T00:00:00+08:00", 
			"stopTime": "2019-08-11T00:00:00+08:00"
		}, 
	"supportedFeatures": "2", 
	"volumePerUE": 
		{
			"duration": 1000, 
			"totalVolume": 2000
		}, 
	"locationArea5G": 
		{"nwAreaInfo": 
			{
				"gRanNodeIds": 
					[
						{"n3IwfId": "a", "plmnId": {"mnc": "136", "mcc": "046"}}
					], 
				"ncgis": 
					[
						{"plmnId": {"mnc": "136", "mcc": "046"}, "nrCellId": "123abcdef"}
					], 
				"tais": 
					[
						{"plmnId": {"mnc": "136", "mcc": "046"}, "tac": "1234"}
					], 
				"ecgis": 
					[
						{"plmnId": {"mnc": "136", "mcc": "046"}, "eutraCellId": "123abcd"}
					]
			}
		}
	
}

      """
    When we send POST request
    Then we expect response status code 201
    Then we expect response time less than 2000 milliseconds
    Then compute SubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm


  Scenario: GET Request
    Given target type is NEF_HTTP
    Given action name is GET_ONE
    Given path is /3gpp-bdt/v1/af111/subscriptions/<SubscriptionId>
    Given request header is Content-Type:application/json
    When we send GET request
    Then we expect response status code 200
    Then we expect response time less than 2000 milliseconds

  Scenario: DELETE BDT
    Given action name is UNSUBSCRIBE
    Given target type is NEF_HTTP
    Given path is /3gpp-bdt/v1/af111/subscriptions/<SubscriptionId>
    When we send DELETE request
    Then we expect response status code 204


