import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';
import 'package:ash__dart/token.dart';

final kys = ChatCommand('kys', 'Shuts down the bot', (
  ChatContext context,
) async {
  if (context.user.id != Snowflake(getOwnerId())) {
    await context.respond(
      MessageBuilder(content: 'You\'re not my twin, gng ✌️🥀 '),
    );
    return;
  }
  await context.respond(MessageBuilder(content: 'Shutting down...'));
  await context.client.close();
});
