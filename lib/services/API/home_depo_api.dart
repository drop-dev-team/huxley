import 'package:http/http.dart' as http;
import 'dart:convert';

/// A class to interact with the SerpApi Home Depot Product API.
/// It provides methods to fetch product details based on a product ID.
class HomeDepotProductAPI {
  /// The API key for accessing SerpApi.
  final String apiKey;

  /// The base URL for the Home Depot Product API.
  final String baseUrl;

  /// Constructor for initializing the HomeDepotProductAPI class with an API key.
  /// [apiKey] is required to authenticate requests to the SerpApi.
  HomeDepotProductAPI({required this.apiKey}) : baseUrl = 'https://serpapi.com/search.json';

  /// Fetches product details from the Home Depot Product API.
  ///
  /// [productId] is a required parameter and specifies the Home Depot product identifier.
  /// [deliveryZip] is an optional parameter to filter products by shipping area.
  /// [storeId] is an optional parameter to filter products by a specific store.
  /// [noCache] is an optional boolean parameter that forces the API to fetch fresh data.
  /// Returns a Future that resolves to a map containing the product details.
  Future<Map<String, dynamic>> getProductDetails(String productId, {String? deliveryZip, String? storeId, bool noCache = false}) async {
    final Map<String, String> queryParameters = {
      'engine': 'home_depot_product',
      'product_id': productId,
      'api_key': apiKey,
      'no_cache': noCache ? 'true' : 'false',
      if (deliveryZip != null) 'delivery_zip': deliveryZip,
      if (storeId != null) 'store_id': storeId,
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product data');
    }
  }
}
