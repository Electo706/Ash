import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchResult {
  final String title;
  final String url;
  final String content;

  SearchResult({required this.title, required this.url, required this.content});
}

class SearchService {
  static const String _endpoint = 'https://api.mwmbl.org/api/v2/search/';

  static Future<List<SearchResult>> search(String query) async {
    final uri = Uri.parse(_endpoint).replace(queryParameters: {'q': query});

    final response = await http.get(uri).timeout(const Duration(seconds: 30));

    if (response.statusCode == 429) {
      throw Exception('Search rate limit or monthly quota reached.');
    }

    if (response.statusCode != 200) {
      throw Exception('Search failed: HTTP ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    // The API response contains a results collection.
    final results = data is List
        ? data
        : data is Map
        ? data['results'] as List? ?? []
        : <dynamic>[];

    final found = <SearchResult>[];
    final seenUrls = <String>{};

    for (final item in results) {
      if (item is! Map) continue;

      final title = _extractText(item['title']);
      final url = item['url']?.toString() ?? '';
      final content = _extractText(item['content'] ?? item['extract']);

      if (url.isEmpty || title.isEmpty) continue;

      final parsedUrl = Uri.tryParse(url);

      if (parsedUrl == null ||
          !{'http', 'https'}.contains(parsedUrl.scheme) ||
          parsedUrl.host.isEmpty) {
        continue;
      }

      if (!seenUrls.add(url)) continue;

      found.add(SearchResult(title: title, url: url, content: content));

      if (found.length >= 5) break;
    }

    return found;
  }

  static String _extractText(dynamic value) {
    if (value is String) return value;

    if (value is List) {
      return value
          .map((item) {
            if (item is String) return item;

            if (item is Map) {
              return item['value']?.toString() ?? '';
            }

            return '';
          })
          .join(' ');
    }

    return '';
  }
}
