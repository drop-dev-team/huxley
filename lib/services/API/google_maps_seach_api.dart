import 'package:http/http.dart' as http;
import 'dart:convert';

/// A class to interact with the SerpApi Google Maps API.
/// It allows performing searches and retrieving details about places using Google Maps data.
class GoogleMapsAPI {
  /// The API key for accessing SerpApi.
  final String apiKey;

  /// The base URL for the Google Maps API.
  final String baseUrl;

  /// Constructor for initializing the GoogleMapsAPI class with an API key.
  /// [apiKey] is required to authenticate requests to the SerpApi.
  GoogleMapsAPI({required this.apiKey}) : baseUrl = 'https://serpapi.com/search.json';

  /// Performs a search on the Google Maps using various parameters.
  ///
  /// [query] specifies the search query string.
  /// [location] specifies the geographic coordinates and zoom level for the search.
  /// [googleDomain] specifies the Google domain to use for the search.
  /// [language] specifies the language for the search results.
  /// [data] specifies filter parameters for searching a specific place.
  /// [placeId] specifies a unique identifier for a place on Google Maps.
  /// [type] specifies the type of search, default is 'search'.
  /// [start] specifies the pagination offset.
  /// [noCache] specifies whether to fetch fresh data or use cached data.
  /// [async] specifies whether to perform the search asynchronously.
  /// Returns a Future that resolves to a map containing the search results.
  Future<Map<String, dynamic>> search({
    String? query,
    String? location,
    String? googleDomain,
    String? language,
    String? data,
    String? placeId,
    String type = 'search',
    int start = 0,
    bool noCache = false,
    bool async = false,
  }) async {
    final Map<String, String> queryParameters = {
      'engine': 'google_maps',
      'api_key': apiKey,
      'type': type,
      'no_cache': noCache ? 'true' : 'false',
      'async': async ? 'true' : 'false',
      'output': 'json',
      if (query != null) 'q': query,
      if (location != null) 'll': location,
      if (googleDomain != null) 'google_domain': googleDomain,
      if (language != null) 'hl': language,
      if (data != null) 'data': data,
      if (placeId != null) 'place_id': placeId,
      'start': start.toString(),
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data from Google Maps API');
    }
  }
}
