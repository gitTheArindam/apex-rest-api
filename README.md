# Apex REST API

A sample project to work with RESTful APIs in Apex.

## OpenStreetMapAPI

This is used to search the OpenStreetMap dataset using [Nominatim API](https://nominatim.org/release-docs/develop/api/Overview/).

-   This class provides method to search the OpenStreetMap dataset using various query parameters.
-   The returned value can be obtained either as Map<String, Object> to be used in Apex class or
-   As JSON string to be used in Lightning component JavaSctipt methods.

**Sample Code Snippet**

-   To get the response as Map

```Java
Map<String, Object> response = OpenStreetMapAPI.search(new Map<String, String> {
    'city' => 'Kolkata',
    'country' => 'India'
}).asMap();
```

-   To retrieve the values from Map

```Java
response.get('lat'); // => 22.5726723
response.get('lon'); // => 88.3638815
```

-   To get the response as JSON String

```Java
String response = OpenStreetMapAPI.search(new Map<String, String> {
    'city' => 'Kolkata',
    'country' => 'India'
}).asJSONString();
```

-   To retrieve the values from JSON in Lightning component

```JavaScript
let responseJson = JSON.parse(response);

responseJson['lat']; // => 22.5726723
responseJson['lon']; // => 88.3638815
```

**Available query parameters**

-   street
-   city
-   county
-   state
-   country
-   postalcode

**Complete Sample response JSON body**

```JSON
{
    "icon": "https://nominatim.openstreetmap.org/ui/mapicons//poi_boundary_administrative.p.20.png",
    "importance": 0.8340385346278307,
    "type": "administrative",
    "category": "boundary",
    "place_rank": 10,
    "display_name": "Kolkata, West Bengal, India",
    "lon": "88.3638815",
    "lat": "22.5726723",
    "boundingbox": [
        "22.4503235",
        "22.6325362",
        "88.2406237",
        "88.4589549"
    ],
    "osm_id": 9381363,
    "osm_type": "relation",
    "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
    "place_id": 283499194
}
```
