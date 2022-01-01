/**
 * Description: Test class for OpenStreetMapAPI
 *              Test class for OpenStreetMapConstants
 *
 * Verson: 1.0.0
 */
@isTest
private class OpenStreetMapAPITest {
    @isTest
    static void testSearchAsMap() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource(OpenStreetMapConstants.OPEN_STREET_MAP_API_MOCK);
        mock.setStatusCode(OpenStreetMapConstants.SUCCESS_STATUS_CODE);
        mock.setHeader(
            OpenStreetMapConstants.CONTENT_TYPE,
            OpenStreetMapConstants.APPLICATION_JSON
        );

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        Map<String, Object> response = OpenStreetMapAPI.search(
                new Map<String, String>{
                    'city' => 'Kolkata',
                    'country' => 'India'
                }
            )
            .asMap();
        Test.stopTest();

        System.assertNotEquals(null, response, 'Response is NOT null!');
        System.assertEquals(
            '22.5726723',
            response.get('lat'),
            'Latitide matched!'
        );
        System.assertEquals(
            '88.3638815',
            response.get('lon'),
            'Longitude matched!'
        );
    }

    @isTest
    static void testSearchAsJSONString() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource(OpenStreetMapConstants.OPEN_STREET_MAP_API_MOCK);
        mock.setStatusCode(OpenStreetMapConstants.SUCCESS_STATUS_CODE);
        mock.setHeader(
            OpenStreetMapConstants.CONTENT_TYPE,
            OpenStreetMapConstants.APPLICATION_JSON
        );

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        String jsonString = OpenStreetMapAPI.search(
                new Map<String, String>{
                    'city' => 'Kolkata',
                    'country' => 'India'
                }
            )
            .asJSONString();
        Test.stopTest();

        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(
            jsonString
        );

        System.assertNotEquals(null, response, 'Response is NOT null!');
        System.assertEquals(
            '22.5726723',
            response.get('lat'),
            'Latitide matched!'
        );
        System.assertEquals(
            '88.3638815',
            response.get('lon'),
            'Longitude matched!'
        );
    }

    @isTest
    static void testHTTPError() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource(OpenStreetMapConstants.OPEN_STREET_MAP_API_MOCK);
        mock.setStatusCode(400);
        mock.setHeader(
            OpenStreetMapConstants.CONTENT_TYPE,
            OpenStreetMapConstants.APPLICATION_JSON
        );

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        Map<String, Object> response = OpenStreetMapAPI.search(
                new Map<String, String>{
                    'city' => 'Kolkata',
                    'country' => 'India'
                }
            )
            .asMap();
        Test.stopTest();

        System.assertEquals(
            new Map<String, Object>{},
            response,
            'Response is empty!'
        );
    }

    @isTest
    static void testException() {
        Test.startTest();
        Map<String, Object> response = OpenStreetMapAPI.search(null).asMap();
        Test.stopTest();

        System.assertEquals(null, response, 'Response is null!');
    }
}