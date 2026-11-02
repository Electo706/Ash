import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

import 'package:ash__dart/ai/ai_service.dart';

final ai = ChatCommand('ai', 'Ask Ash AI a question', (
  ChatContext context,
  String question,
) async {
  // Prevent excessively long prompts.
  if (question.length > 1000) {
    await context.respond(
      MessageBuilder(
        content: 'That question is too long! Keep it under 1000 characters.',
      ),
    );
    return;
  }

  // Defer slash-command interactions while the AI thinks.
  if (context is InteractionChatContext) {
    await context.acknowledge();
  }

  try {
    final answer = await AiService.ask(question);

    // Discord messages have a 2000-character limit.
    final output = answer.length > 1900
        ? '${answer.substring(0, 1890)}... (truncated)'
        : answer;

    await context.respond(MessageBuilder(content: output));
  } catch (e) {
    print('Ash AI error: $e');

    await context.respond(
      MessageBuilder(content: 'My brain exploded. Check the Ollama server. 💀'),
    );
  }
});
