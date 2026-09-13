import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';

import 'dart:io';

String curPrefix = '%';
// Logic to set the bot's prefix
// This is a placeholder implementation; you would typically store this in a database or configuration file.
String setPrefix(String newPrefix) {
  curPrefix = newPrefix;
  return curPrefix;
}

final ping = ChatCommand('ping', "Get the bot's latency", (
  ChatContext context,
) async {
  final latency = context.client.httpHandler.latency;
  final formattedLatency =
      (latency.inMicroseconds / Duration.microsecondsPerMillisecond)
          .toStringAsFixed(3);
  await context.respond(MessageBuilder(content: '${formattedLatency}ms'));
});

final albuquerquenewmexico = ChatCommand(
  'albuquerquenewmexico',
  'ALBUQUERQUE NEW MEXICO',
  (ChatContext context) async {
    var gif = 'https://klipy.com/gifs/kitboga-sus';

    await context.respond(MessageBuilder(content: gif));
  },
);
