import 'dart:io';

import 'package:ash__dart/token.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

const String _projectDir = '/home/brady-husong/Bots/Ash';

Future<ProcessResult> _run(String executable, List<String> arguments) {
  return Process.run(executable, arguments, workingDirectory: _projectDir);
}

String _output(ProcessResult result) {
  final stdoutText = result.stdout.toString().trim();
  final stderrText = result.stderr.toString().trim();

  return [stdoutText, stderrText].where((text) => text.isNotEmpty).join('\n');
}

// everything above this i have no clue how it works dont ask me
final update = ChatCommand(
  'update',
  'Update Ash from GitHub and restart the bot',
  (ChatContext context) async {
    // Only the configured bot owner can update the server.
    if (context.user.id != Snowflake(getOwnerId())) {
      await context.respond(
        MessageBuilder(
          content: 'You do not have permission to use this command.',
        ),
      );
      return;
    }

    // Acknowledge immediately so Discord does not time out.
    await context.respond(
      MessageBuilder(content: 'Ash update started. Please wait...'),
    );
    try {
      // Refuse to overwrite local changes.
      var result = await _run('git', ['status', '--porcelain']);

      if (result.exitCode != 0) {
        await context.respond(
          MessageBuilder(content: 'Could not check Git status.'),
        );
        return;
      }

      if (result.stdout.toString().trim().isNotEmpty) {
        await context.respond(
          MessageBuilder(
            content:
                'Update cancelled: the server has uncommitted changes. '
                'Commit, stash, or safely resolve them first.',
          ),
        );
        return;
      }

      // Fetch the latest remote commits.
      result = await _run('git', ['fetch', 'origin']);

      if (result.exitCode != 0) {
        await context.respond(
          MessageBuilder(content: 'Git fetch failed:\n${_output(result)}'),
        );
        return;
      }

      // Only update the main branch with a fast-forward.
      result = await _run('git', ['pull', '--ff-only', 'origin', 'main']);

      if (result.exitCode != 0) {
        await context.respond(
          MessageBuilder(
            content:
                'Git pull failed; Ash was not restarted.\n'
                '${_output(result)}',
          ),
        );
        return;
      }

      // Install/update Dart dependencies.
      result = await _run('/usr/bin/dart', ['pub', 'get']);

      if (result.exitCode != 0) {
        await context.respond(
          MessageBuilder(
            content:
                'Dependency installation failed. '
                'Ash was not restarted.\n${_output(result)}',
          ),
        );
        return;
      }

      // Respond before restarting the service.
      await context.respond(
        MessageBuilder(
          content:
              'Update downloaded and dependencies installed. '
              'Restarting Ash now!',
        ),
      );

      // Requires a narrowly scoped passwordless sudo rule.
      final restart = await Process.run('sudo', [
        '-n',
        '/usr/bin/systemctl',
        'restart',
        'ash.service',
      ], workingDirectory: _projectDir);

      if (restart.exitCode != 0) {
        stderr.writeln('Ash restart failed: ${_output(restart)}');
      }
    } catch (error, stackTrace) {
      stderr.writeln('Ash update failed: $error');
      stderr.writeln(stackTrace);
    }
  },
);
