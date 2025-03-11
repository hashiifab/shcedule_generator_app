import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "AIzaSyAstGn9Q-emOoVjq38Q8WtIUyfTQifmbrc";
  static const String baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  static Future<String> generateSchedule(List<Map<String, dynamic>> tasks) async {
    final prompt = _buildPrompt(tasks);

    final response = await http.post(
      Uri.parse('$baseUrl?key=$apiKey'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String text = data["candidates"][0]["content"]["parts"][0]["text"];
      return text.replaceAll(RegExp(r"\*"), "");
    } else {
      throw Exception("Gagal menghasilkan jadwal: ${response.body}");
    }
  }

  static String _buildPrompt(List<Map<String, dynamic>> tasks) {
    String taskList = tasks
        .map((task) => "- ${task['name']} (Prioritas: ${task['priority']}, Durasi: ${task['duration']} menit, Deadline: ${task['deadline']})")
        .join("\n");

    return "Buatkan jadwal harian yang optimal untuk tugas-tugas berikut:\n$taskList\nSusun jadwal dari pagi hingga malam dengan efisien.";
  }
}
