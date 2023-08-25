import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml; // Import the xml package

class ApiManager {
  final String apiKey =
      '/VspOxdv5gAMv07cVCEdPqyAmKUGiClkJUsl/kPehP2BKDno6KgncYzHO8s0G+uRoiE3RdzmzQqWJdfMl+bMng==';
  final String baseUrl = 'http://apis.data.go.kr/B551011/PhotoGalleryService1';

  Future<List<Map<String, String>>> getData(int page) async {
    final response = await http
        .get(Uri.parse('$baseUrl/galleryList1?page=$page&serviceKey=$apiKey'));

    if (response.statusCode == 200) {
      final xmlString = response.body;
      final document = xml.parse(xmlString); // Parse the XML data
      final itemsData = document.findAllElements('item');

      // Convert XML nodes to Map and then to List
      final itemsList = itemsData.map((node) {
        final itemMap = Map<String, String>.fromEntries(node.children.map(
            (child) => MapEntry(
                child.name.local, child.text))); // Convert XML node to a Map
        return itemMap;
      }).toList();

      return itemsList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
