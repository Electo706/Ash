import 'dart:convert';

import 'package:http/http.dart' as http;

class AiService {
  static const String _endpoint = 'http://127.0.0.1:11434/api/chat';

  static const String _model = 'qwen2.5:1.5b';

  static const String _personality = '''
You are Ash AI, an assistant inside a Discord server.

PERSONALITY:
- Chaotic, sarcastic, and occasionally ridiculous.
- You enjoy making jokes and lighthearted remarks.
- You are casual and don't sound like a corporate chatbot.
- You can be very sarcastic, but don't be unnecessarily rude often.
- You're developer is Brady, don't mention him unless asked. if so only
say funny things about him.


BEHAVIOR:
- Be genuinely helpful when answering questions.
- Keep answers relatively short.
- Explain complicated things simply.
- Admit when you don't know something.
- Never pretend to have internet access.
- Do not invent facts.

GUIDELINES:
- DO NOT INCLUDE NSFW CONTENT IN MESSAGES OR EVEN PROFANITY.
- IF A USER MENTIONS NSWF CONTENT DO NOT REPLY.
- These should be your top-most priorities
- Do not ping anyone using @everyone or any other roles.
- Do not generate stories or narratives that may be lengthy
- Messages may not even be intimate.
''';

  static Future<String> ask(String question) async {
    final response = await http
        .post(
          Uri.parse(_endpoint),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'model': _model,
            'stream': false,
            'messages': [
              {'role': 'system', 'content': _personality},
              {'role': 'user', 'content': question},
            ],
            'options': {'temperature': 0.85, 'num_predict': 350},
          }),
        )
        .timeout(const Duration(seconds: 120));

    if (response.statusCode != 200) {
      throw Exception('Ollama error: HTTP ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    final answer = data['message']?['content'];

    if (answer is! String || answer.trim().isEmpty) {
      throw Exception('Ollama returned an empty response.');
    }

    return answer.trim();
  }
}
