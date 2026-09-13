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
  prefixFile.writeAsStringSync(newPrefix);

  await context.respond(
    MessageBuilder(content: 'Prefix updated to: $newPrefix'),
  );
});
