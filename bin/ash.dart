import 'package:ash__dart/token.dart';
import 'package:ash__dart/commands.dart';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

import 'dart:io';

void main() async {
  File prefixFile = File(
    '/Users/bradyhusong/Documents/Programming Work/Ash-Dart/lib/prefix.txt',
  );

  final commands = CommandsPlugin(
    prefix: mentionOr((_) async {
      // Reads the updated content from disk on every command check
      final content = await prefixFile.readAsString();
      return content.trim();
    }),
  );
  commands.addCommand(ping);
  commands.addCommand(albuquerquenewmexico);
  commands.addCommand(prefix);
  commands.addCommand(scoreboard);

  final client = await Nyxx.connectGateway(
    getBotToken(),
    GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
    options: GatewayClientOptions(plugins: [logging, cliIntegration, commands]),
  );

  final botUser = await client.user.get();

  client.onMessageCreate.listen((event) async {
    if (event.message.author.id == botUser.id) return;
    if (event.message.author is User && (event.message.author as User).isBot) {
      return;
    }
    if (event.message.reference != null) return;

    final wasMentioned = event.message.mentions.any(
      (user) => user.id == botUser.id,
    );

    if (wasMentioned) {
      await event.message.channel.sendMessage(
        MessageBuilder(
          content: "Hello there!",
          referencedMessage: .reply(messageId: event.message.id),
        ),
      );
    }
  });
}
