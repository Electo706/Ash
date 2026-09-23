import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';

final albuquerquenewmexico = ChatCommand(
  'albuquerquenewmexico',
  'ALBUQUERQUE NEW MEXICO',
  aliases: ["alb", "anm"],
  (ChatContext context) async {
    var gif = 'https://klipy.com/gifs/kitboga-sus';

    await context.respond(MessageBuilder(content: gif));
  },
);

final dih = ChatCommand('dih', 'dih', (ChatContext context) async {
  var gif = 'https://klipy.com/gifs/hopindih';
  await context.respond(MessageBuilder(content: gif));
});

final peak = ChatCommand('peak', 'peak gif', (ChatContext context) async {
  var gif = 'https://klipy.com/gifs/patrick-patrick-star-54';
  await context.respond(MessageBuilder(content: gif));
});
