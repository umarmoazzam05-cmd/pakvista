// ai_trip_planner_card.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ==============================
// Replace with your OpenRouter API Key
// ==============================
const String OPENROUTER_API_KEY =
    String.fromEnvironment('OPENROUTER_API_KEY');

class AITripPlannerCard extends StatelessWidget {
  const AITripPlannerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.travel_explore, color: Colors.blueAccent, size: 32),
        title: const Text(
          "AI Trip Planner",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Plan your trips using AI"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AITripPlannerScreen()),
          );
        },
      ),
    );
  }
}

/// ==============================
/// Full-screen AI Trip Planner
/// ==============================
class AITripPlannerScreen extends StatefulWidget {
  const AITripPlannerScreen({Key? key}) : super(key: key);

  @override
  State<AITripPlannerScreen> createState() => _AITripPlannerScreenState();
}

class _AITripPlannerScreenState extends State<AITripPlannerScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = "";
  bool _isLoading = false;

  /// Working Fallback Models (All Free)
  final List<String> fallbackModels = [
    "mistralai/mistral-7b-instruct:free",
  ];

  /// Function to call OpenRouter with fallback
  Future<void> _getTripSuggestions(String prompt) async {
    setState(() {
      _isLoading = true;
      _response = "";
    });

    bool success = false;

    for (String model in fallbackModels) {
      try {
        final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");

        final res = await http.post(
          url,
          headers: {
            "Authorization": "Bearer $OPENROUTER_API_KEY",
            "Content-Type": "application/json",
            "HTTP-Referer": "https://localhost",
            "X-Title": "PakVista",
          },
          body: jsonEncode({
            "model": model,
            "messages": [
            {
              "role": "system",
              "content": "You are PakVista, a Pakistan only tourism guide assistant. Respond in clean plain text without using hashtags, asterisks, markdown formatting, or symbols like #, *, or bullets made from other characters. Use only hyphens and numbers for lists.\n\nYour responsibilities:\n\n1. City and Area Guidance:\n- Suggest places to visit, major attractions, historical sites, natural spots, food areas, and lesser known locations.\n\n2. Stay Recommendations:\n- Recommend safe and commonly known hotels or guest houses in different price ranges.\n\n3. Route Guidance:\n- Provide best travel routes between cities or tourist spots within Pakistan.\n- Include estimated travel times, transport methods, and clear directions.\n- Mention route safety and weather warnings when necessary.\n\n4. Travel Tips:\n- Provide best visiting seasons, approximate budgets, clothing suggestions, cultural information, weather notes, safety tips, food suggestions, and transport options.\n\n5. Response Style:\n- Keep answers clear, organized, and practical.\n- Use short paragraphs and lists made only with hyphens or numbers.\n- Do not use markdown formatting or decorative characters.\n\n6. Scope Rules:\n- Only provide guidance related to Pakistan.\n- If asked about another country, state that you only provide tourism assistance for Pakistan.\n\n7. Safety:\n- Avoid political, medical, legal, or unsafe advice.\n- Recommend only safe and commonly used travel routes.\n\n8. Accuracy:\n- If information is uncertain, clearly say you do not know and avoid guessing.\n\nMaintain a neutral and professional tone focused on tourism."
            },

              {"role": "user", "content": prompt}
            ]
          }),
        );

        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);

          final content =
              data["choices"]?[0]?["message"]?["content"]?.trim();

          if (content != null && content.isNotEmpty) {
            setState(() {
              _response = content;
            });
            success = true;
            break;
          } else {
            print("Empty response from model: $model");
          }
        }

      } catch (e) {
        continue;
      }
    }

    if (!success) {
      setState(() {
        _response = "All models failed. Try again later.";
      });
    }
    

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Trip Planner"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Input Field
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Enter destination or preferences",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _getTripSuggestions(_controller.text);
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Output Area
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _response,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
