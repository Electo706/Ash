import 'package:dotenv/dotenv.dart';

String getBotToken() {
  String botToken = (DotEnv(includePlatformEnvironment: true)
    ..load())["TOKEN"]!;
  return botToken;
}

int getOwnerId() {
  int ownerId = int.parse(
    (DotEnv(includePlatformEnvironment: true)..load())["OWNER_ID"]!,
  );
  return ownerId;
}
