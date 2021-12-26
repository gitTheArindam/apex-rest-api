public with sharing class OpenStreetMapAPI {

    public static void getOpenStreetMapData(String city, String country) {
        List<OpenStreetMapDataWrapper> dataWrapperList = new List<OpenStreetMapDataWrapper>();

        // String city = 'Kolkata';
        // String country = 'India';
        String endPoint = System.Label.OpenStreetMap_Base_URL;
        endPoint += OpenStreetMapConstants.URL_PARAM_CITY + city + OpenStreetMapConstants.URL_PARAM_COUNTRY + country + OpenStreetMapConstants.URL_SUFFIX;
        System.debug('endPoint: ' + endPoint);

        String method = OpenStreetMapConstants.METHOD_GET;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        request.setEndpoint(endPoint);
        request.setHeader(OpenStreetMapConstants.CONTENT_TYPE, OpenStreetMapConstants.APPLICATION_JSON);
        HttpResponse response = http.send(request);

        System.debug('Status Code: '+ response.getStatusCode());
        System.debug('Body: '+ response.getBody());
        if(response.getStatusCode() == OpenStreetMapConstants.SUCCESS_STATUS_CODE) {
            String inputJson = response.getBody();
            inputJson = inputJson.replace(OpenStreetMapConstants.CLASS_STRING, OpenStreetMapConstants.CLASSNAME_STRING);
            inputJson = inputJson.replace(OpenStreetMapConstants.TYPE_STRING, OpenStreetMapConstants.TYPENAME_STRING);
            dataWrapperList = (List<OpenStreetMapDataWrapper>)JSON.deserializeStrict(inputJson, List<OpenStreetMapDataWrapper>.class);
        }

        if(dataWrapperList != null) {
            for(OpenStreetMapDataWrapper wrap : dataWrapperList) {
                System.debug('Title: ' + wrap.display_name);
                System.debug('Latitude: ' + Decimal.valueOf(wrap.lat));
                System.debug('Longitude: ' + Decimal.valueOf(wrap.lon));
            }
        }
    }
    
    public class OpenStreetMapDataWrapper {
        public Integer place_id;
        public String licence;
        public String osm_type;
        public String osm_id;
        public List<String> boundingbox;
        public String lat;
        public String lon;
        public String display_name;
        public String className; // => "class" in actual JSON
        public String typeName; // => "type" in actual JSON
        public String importance;
        public String icon;
    }
}