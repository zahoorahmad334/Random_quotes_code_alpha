import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_quotes/quote_model.dart';

class Api {
  static const String baseUrl = "https://zenquotes.io/api/";

  static Future<QuoteModel> fetchRandomQuote() async {
    final response = await http.get(Uri.parse("${baseUrl}random"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return QuoteModel.fromJson(data[0]);
    } else {
      throw Exception("Failed to generate quote");
    }
  }
}