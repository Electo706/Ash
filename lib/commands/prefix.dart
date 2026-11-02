import 'package:ash__dart/token.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';
import 'package:ash__dart/commands/dev.dart';

import 'dart:io';

File prefixFile = File('lib/prefix.txt');

final prefix = ChatCommand('prefix', 'Set the bot\'s command prefix', (
  ChatContext context,
  String newPrefix,
) async {
  if (context.user.id == Snowflake(getOwnerId())) {
    final activePrefix = dev == true ? '${newPrefix}d' : newPrefix;

    prefixFile.writeAsStringSync(activePrefix);

    await context.respond(
      MessageBuilder(
        content: '${dev ? "DevPrefix" : "Prefix"} updated to: $activePrefix',
      ),
    );
  } else {
    await context.respond(
      MessageBuilder(content: 'You\'re not my twin, gng ✌️🥀'),
    );
  }
}); // ChatCommand;
