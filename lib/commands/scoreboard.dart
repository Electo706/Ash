import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';
import 'package:ash__dart/token.dart';

import 'dart:io';

final scoreboard = ChatCommand('scoreboard', 'Get the current scoreboard', (
  ChatContext context, [
  @Description("People you are changing the score of") String? person,
  @Description("The new score, NOT score added") int? score,
]) async {
  List<Snowflake> allowedUsers = [
    Snowflake(getOwnerId()), // My Discord ID
    Snowflake(1371275897973244016), // Ryan's Dihcord ID
  ];

  File boyzScore = File(
    '/Users/bradyhusong/Documents/Programming Work/Ash-Dart/lib/boyz_score.txt',
  );
  File abbyScore = File(
    '/Users/bradyhusong/Documents/Programming Work/Ash-Dart/lib/abby_score.txt',
  );
  String currentBoyzScore = boyzScore.readAsStringSync();
  String currentAbbyScore = abbyScore.readAsStringSync();

  if (allowedUsers.contains(context.user.id)) {
    if ((person == 'boyz') && (score != null)) {
      boyzScore.writeAsStringSync(score.toString());
      currentBoyzScore = boyzScore.readAsStringSync();
      await context.respond(
        MessageBuilder(
          content: 'Scoreboard: $currentBoyzScore:$currentAbbyScore',
        ),
      );
    }
    if ((person == 'abby') && (score != null)) {
      abbyScore.writeAsStringSync(score.toString());
      currentAbbyScore = abbyScore.readAsStringSync();
      await context.respond(
        MessageBuilder(
          content: 'Scoreboard: $currentBoyzScore:$currentAbbyScore',
        ),
      );
    } else if ((!allowedUsers.contains(context.user.id)) &&
        (person != null || score != null)) {
      await context.respond(
        MessageBuilder(
          content: "You aren't permitted to change the scoreboard.",
        ),
      );
    }
  }
  if ((person != 'boyz') && (person != 'abby')) {
    await context.respond(
      MessageBuilder(
        content: 'Scoreboard: $currentBoyzScore:$currentAbbyScore',
      ),
    );
  }
});
