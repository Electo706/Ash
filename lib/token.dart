import 'package:dotenv/dotenv.dart';

String getBotToken() {
  String botToken = (DotEnv(includePlatformEnvironment: true)
    ..load())["TOKEN"]!;
  return botToken;
}
