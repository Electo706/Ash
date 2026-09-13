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

final scoreboard = ChatCommand('scoreboard', 'Get the current scoreboard', (
  ChatContext context, [
  String? person,
  int? score,
]) async {
  File boyzScore = File(
    '/Users/bradyhusong/Documents/Programming Work/Ash-Dart/lib/boyz_score.txt',
  );
  File abbyScore = File(
    '/Users/bradyhusong/Documents/Programming Work/Ash-Dart/lib/abby_score.txt',
  );
  String currentBoyzScore = boyzScore.readAsStringSync();
  String currentAbbyScore = abbyScore.readAsStringSync();
  if ((person == 'boyz') && score != null) {
    boyzScore.writeAsStringSync(score.toString());
    currentBoyzScore = boyzScore.readAsStringSync();

    await context.respond(
      MessageBuilder(
        content: 'Scoreboard:   $currentBoyzScore:$currentAbbyScore',
      ),
    );
  }
  if ((person == 'abby') && score != null) {
    abbyScore.writeAsStringSync(score.toString());
    currentAbbyScore = abbyScore.readAsStringSync();
    await context.respond(
      MessageBuilder(
        content: 'Scoreboard:  $currentBoyzScore:$currentAbbyScore',
      ),
    );
  }

  if ((person != 'boyz') && (person != 'abby')) {
    await context.respond(
      MessageBuilder(
        content: 'Scoreboard:  $currentBoyzScore:$currentAbbyScore',
      ),
    );
  }
});
