import 'package:ash__dart/token.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';

import 'dart:io';

File prefixFile = File(
  '/Users/bradyhusong/Documents/Programming Work/Ash-Dart/lib/prefix.txt',
);

final prefix = ChatCommand('prefix', 'Set the bot\'s command prefix', (
  ChatContext context,
  String newPrefix,
) async {
  if (context.user.id == Snowflake(getOwnerId())) {
    prefixFile.writeAsStringSync(newPrefix);

    await context.respond(
      MessageBuilder(content: 'Prefix updated to: $newPrefix'),
    );
  } else {
    await context.respond(
      MessageBuilder(content: "You are not permitted to use this command"),
    );
  }
});
