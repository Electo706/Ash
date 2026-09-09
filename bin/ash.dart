import 'package:ash__dart/token.dart';
import 'package:ash__dart/commands.dart';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

void main() async {
  final commands = CommandsPlugin(prefix: mentionOr((_) => '%'));
  commands.addCommand(ping);

  final client = await Nyxx.connectGateway(
    getBotToken(),
    GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
    options: GatewayClientOptions(plugins: [logging, cliIntegration, commands]),
  );

  final botUser = await client.user.get();

  client.onMessageCreate.listen((event) async {
    if (event.mentions.contains(botUser)) {
      await event.message.channel.sendMessage(
        MessageBuilder(
          content: "Hello there!",
          referencedMessage: .reply(messageId: event.message.id),
        ),
      );
    }
  });
}
