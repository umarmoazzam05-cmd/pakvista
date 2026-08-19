import 'dart:convert';
import 'package:http/http.dart' as http;

class AITripPlannerService {
 final String apiKey = String.fromEnvironment('OPENROUTER_API_KEY');

  Future<String> generateTripPlan(String userInput) async {
    final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://localhost",
        "X-Title": "PakVista",
      },
      body: jsonEncode({
        "model": "mistralai/mistral-7b-instruct:free",
        "messages": [
          {"role": "user", "content": userInput}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"];
    } else {
      return "Error: ${response.body}";
    }
  }
}
