import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx/nyxx.dart';

import 'package:system_info3/system_info3.dart';

//import 'package:battery_plus/battery_plus.dart';

const int gibibyte = 1024 * 1024 * 1024;

final ChatCommand status = ChatCommand('status', 'Get the Bot\'s PC info', (
  ChatContext context,
) async {
  var OS = SysInfo.operatingSystemName;
  var OSVersion = SysInfo.operatingSystemVersion;
  var kernelType = SysInfo.kernelArchitecture;
  var kernelVersion = SysInfo.kernelVersion;
  var cpuName = SysInfo.cores[0].name;
  var cpuCores = SysInfo.cores.length;
  var cpuSocket = SysInfo.cores[0].socket;
  var totalMemory = (SysInfo.getTotalPhysicalMemory());
  var freeMemory = (SysInfo.getFreePhysicalMemory());
  var usedMemory = totalMemory - freeMemory;
  //var battery = Battery();
  //var batteryLevel = await battery.batteryLevel;
  //var batteryState = await battery.batteryState;

  await context.respond(
    MessageBuilder(
      content:
          '```'
          'OS: $OS $OSVersion\n'
          'Kernel: $kernelType $kernelVersion\n'
          'CPU: $cpuName ($cpuCores cores, $cpuSocket socket)\n'
          'Memory: ${(usedMemory / gibibyte).toStringAsFixed(2)} GiB / '
          '${(totalMemory / gibibyte).toStringAsFixed(2)} GiB\n'
          //'Battery: $batteryLevel% ($batteryState)\n'
          '```',
    ),
  );
});
