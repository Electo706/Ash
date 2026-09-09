import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';

final ping = ChatCommand('ping', "Get the bot's latency", (
  ChatContext context,
) async {
  final latency = context.client.httpHandler.latency;
  final formattedLatency =
      (latency.inMicroseconds / Duration.microsecondsPerMillisecond)
          .toStringAsFixed(3);
  await context.respond(MessageBuilder(content: '${formattedLatency}ms'));
  // ...
});
