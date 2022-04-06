LOCAL loRest
LOCAL lnBTls
LOCAL lnPort
LOCAL lnBAutoReconnect
LOCAL lnSuccess
LOCAL loJson
LOCAL loACellTowers
LOCAL loOCellTower
LOCAL loAWifi
LOCAL loOPoint
LOCAL lcResponseJson
LOCAL loJsonResp
LOCAL loJsonLoc
LOCAL lcLatitude
LOCAL lcLongitude
LOCAL lcAccuracy

*  This example duplicates the following CURL request:
*  curl -d @your_filename.json -H "Content-Type: application/json" -i "https://www.googleapis.com/geolocation/v1/geolocate?key=YOUR_API_KEY"

*  This example requires the Chilkat API to have been previously unlocked.
*  See Global Unlock Sample for sample code.

loRest = CreateObject('Chilkat_9_5_0.Rest')

*  Connect to the Google API REST server.
lnBTls = 1
lnPort = 443
lnBAutoReconnect = 1
lnSuccess = loRest.Connect("www.googleapis.com",lnPort,lnBTls,lnBAutoReconnect)

*  Add the Content-Type request header.
loRest.AddHeader("Content-Type","application/json")

*  Add your API key as a query parameter
loRest.AddQueryParam("key","YOUR_API_KEY")

*  The JSON query is contained in the body of the HTTP POST.
*  This is a sample query (which we'll dynamically build in this example)
*  {
*   "homeMobileCountryCode": 310,
*   "homeMobileNetworkCode": 260,
*   "radioType": "gsm",
*   "carrier": "T-Mobile",
*   "cellTowers": [
*    {
*    "cellId": 39627456,
*     "locationAreaCode": 40495,
*     "mobileCountryCode": 310,
*     "mobileNetworkCode": 260,
*     "age": 0,
*     "signalStrength": -95
*    }
*   ],
*   "wifiAccessPoints": [
*    {
*     "macAddress": "01:23:45:67:89:AB",
*     "signalStrength": 8,
*     "age": 0,
*     "signalToNoiseRatio": -65,
*     "channel": 8
*    },
*    {
*     "macAddress": "01:23:45:67:89:AC",
*     "signalStrength": 4,
*     "age": 0
*    }
*   ]
*  }

loJson = CreateObject('Chilkat_9_5_0.JsonObject')
loJson.AppendInt("homeMobileCountryCode",310)
loJson.AppendInt("homeMobileNetworkCode",260)
loJson.AppendString("radioType","gsm")
loJson.AppendString("carrier","T-Mobile")
loACellTowers = loJson.AppendArray("cellTowers")
loACellTowers.AddObjectAt(0)
loOCellTower = loACellTowers.ObjectAt(0)
loOCellTower.AppendInt("cellId",39627456)
loOCellTower.AppendInt("locationAreaCode",40495)
loOCellTower.AppendInt("mobileCountryCode",310)
loOCellTower.AppendInt("mobileNetworkCode",260)
loOCellTower.AppendInt("age",0)
loOCellTower.AppendInt("signalStrength",-95)
RELEASE loOCellTower
RELEASE loACellTowers
loAWifi = loJson.AppendArray("wifiAccessPoints")
loAWifi.AddObjectAt(0)
loOPoint = loAWifi.ObjectAt(0)
loOPoint.AppendString("macAddress","01:23:45:67:89:AB")
loOPoint.AppendInt("signalStrength",8)
loOPoint.AppendInt("age",0)
loOPoint.AppendInt("signalToNoiseRatio",-65)
loOPoint.AppendInt("channel",8)
RELEASE loOPoint
loAWifi.AddObjectAt(1)
loOPoint = loAWifi.ObjectAt(1)
loOPoint.AppendString("macAddress","01:23:45:67:89:AC")
loOPoint.AppendInt("signalStrength",4)
loOPoint.AppendInt("age",0)
RELEASE loOPoint
RELEASE loAWifi

lcResponseJson = loRest.FullRequestString("POST","/geolocation/v1/geolocate",loJson.Emit())
IF (loRest.LastMethodSuccess <> 1) THEN
    ? loRest.LastErrorText
    RELEASE loRest
    RELEASE loJson
    CANCEL
ENDIF

*  When successful, the response code is 200.
IF (loRest.ResponseStatusCode <> 200) THEN
    *  Examine the request/response to see what happened.
    ? "response status code = " + STR(loRest.ResponseStatusCode)
    ? "response status text = " + loRest.ResponseStatusText
    ? "response header: " + loRest.ResponseHeader
    ? "response JSON: " + lcResponseJson
    ? "---"
    ? "LastRequestStartLine: " + loRest.LastRequestStartLine
    ? "LastRequestHeader: " + loRest.LastRequestHeader
    RELEASE loRest
    RELEASE loJson
    CANCEL
ENDIF

loJson.EmitCompact = 0
? "JSON request body: " + loJson.Emit()

*  The JSON response should look like this:
*  {
*   "location": {
*   "lat": 37.4248297,
*    "lng": -122.07346549999998
*   },
*   "accuracy": 1145.0
*  }

? "JSON response: " + lcResponseJson

loJsonResp = CreateObject('Chilkat_9_5_0.JsonObject')
loJsonResp.Load(lcResponseJson)

loJsonLoc = loJsonResp.ObjectOf("location")
*  Any JSON value can be obtained as a string..
lcLatitude = loJsonLoc.StringOf("lat")
? "latitude = " + lcLatitude
lcLongitude = loJsonLoc.StringOf("lng")
? "longitude = " + lcLongitude
RELEASE loJsonLoc

lcAccuracy = loJsonResp.StringOf("accuracy")
? "accuracy = " + lcAccuracy

RELEASE loRest
RELEASE loJson
RELEASE loJsonResp