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
); //albuquerque new mexico gif

final dih = ChatCommand('dih', 'dih', (ChatContext context) async {
  var gif = 'https://klipy.com/gifs/hopindih';
  await context.respond(MessageBuilder(content: gif));
}); //hoppin dih gif

final peak = ChatCommand('peak', 'peak gif', (ChatContext context) async {
  var gif = 'https://klipy.com/gifs/patrick-patrick-star-54';
  await context.respond(MessageBuilder(content: gif));
}); //peak command

final bootyshake = ChatCommand(
  'bootyshake',
  'booty shake gif',
  aliases: ["bradydoesthebootyshake", "bradybootyshake"],
  (ChatContext context) async {
    var gif =
        'https://tenor.com/view/open-season-boog-elliot-sicko-mode-booty-shake-gif-15909219';

    await context.respond(MessageBuilder(content: gif));
  },
); //bootyshake command

final dipping = ChatCommand(
  'dipping',
  'dipping gif',
  aliases: ["dippin", "TitusDipping", "ishedipping"],
  (ChatContext context) async {
    var gif =
        'https://cdn.discordapp.com/attachments/1373406778766790757/1568343649614434446/copy_624E3919-8133-4237-8124-DE9E65A193B9.gif?ex=6aef7958&is=6aee27d8&hm=d232b92f4c41c2e506a657378deae13e9f6ca4922529da5730aa70bfb9f887a5&';

    await context.respond(MessageBuilder(content: gif));
  },
); //dipping command
