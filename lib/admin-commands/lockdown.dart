import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

import 'package:ash__dart/token.dart';
import 'package:ash__dart/lockdown_service.dart';

final lockdown = ChatCommand('lockdown', 'Manage Ash lockdown mode', (
  ChatContext context,
  String action,
) async {
  // Only the bot owner can manage lockdown.
  if (context.user.id != Snowflake(getOwnerId())) {
    await context.respond(
      MessageBuilder(content: 'You are not authorized to do that.'),
    );
    return;
  }

  switch (action.toLowerCase()) {
    case 'on':
      await LockdownService.set(true);
      await context.respond(
        MessageBuilder(content: 'Lockdown enabled. Ash is now restricted.'),
      );
      break;

    case 'off':
      await LockdownService.set(false);
      await context.respond(
        MessageBuilder(content: 'Lockdown disabled. Ash is available again.'),
      );
      break;

    case 'status':
      await context.respond(
        MessageBuilder(
          content: LockdownService.enabled
              ? 'Lockdown is currently enabled.'
              : 'Lockdown is currently disabled.',
        ),
      );
      break;

    default:
      await context.respond(
        MessageBuilder(content: 'Use `on`, `off`, or `status`.'),
      );
  }
});
