public with sharing class OpenStreetMapAPI {
    
    public class OpenStreetMapAPIResponse {
        
        public Map<String, Object> responseMap;

        public Map<String, Object> asMap() {
            return this.responseMap;
        }

        public String asJSONString() {
            return JSON.serialize(this.responseMap);
        }
    }

    public static OpenStreetMapAPIResponse search(Map<String, String> params) {
        String endPoint = System.Label.OpenStreetMap_Base_URL;
        Set<String> paramSet = new Set<String>();
        List<String> paramList = new List<String>();
        if (params != null) {
            for (String param : params.keySet()) {
                if (params.get(param) != null) {
                    String p = param.toLowerCase() + '=' + params.get(param);
                    paramSet.add(p);
                }
            }
        }
        if (paramSet != null) {
            paramList.addAll(paramSet);
            endPoint += String.join(paramList, '&');
            endPoint += OpenStreetMapConstants.URL_SUFFIX;
        }

        OpenStreetMapAPIResponse apiResponse = new OpenStreetMapAPIResponse();
        call(apiResponse, endPoint);
        return apiResponse;
    }

    public static void call(OpenStreetMapAPIResponse apiResponse, String endPoint) {
        Map<String, Object> responseMap = new Map<String, Object>();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod(OpenStreetMapConstants.METHOD_GET);
        request.setEndpoint(endPoint);
        request.setHeader(OpenStreetMapConstants.CONTENT_TYPE, OpenStreetMapConstants.APPLICATION_JSON);
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == OpenStreetMapConstants.SUCCESS_STATUS_CODE) {
            String inputJson = response.getBody();
            List<Object> responseList = (List<Object>)JSON.deserializeUntyped(inputJson);

            for (Object respObj : responseList) {
                responseMap = (Map<String, Object>)respObj;
            }
            if (responseMap != null) {
                apiResponse.responseMap = responseMap;
            }
        }
    }
}