import 'dart:isolate';

import 'args_parser.dart';
import 'command_executor.dart';
import 'worker.dart';

main(List<String> args) async {
  Map config = parseArgs(args);

  ReceivePort fromWorkers = new ReceivePort();
  ReceivePort fromCommandExecutor = new ReceivePort();
  await Isolate.spawn(runCommandExecutor, {
    'toMaster': fromWorkers.sendPort,
    'temp': fromCommandExecutor.sendPort
  });
  SendPort toCommandExecutor = await fromCommandExecutor.first;

  for (int workerId = 0; workerId < config['threads']; workerId++) {
    config['toMaster'] = fromWorkers.sendPort;
    config['toCommandExecutor'] = toCommandExecutor;
    config['id'] = workerId.toString();

    await Isolate.spawn(runWorker, config);
  }

  List<SendPort> toWorkers = new List<SendPort>();
  await for (var message in fromWorkers) {
    if (message is SendPort) {
      print('Broker has got send port from worker.');
      toWorkers.add(message);
      continue;
    }

    print("Broker sends message '${message.text}' to all workers.");
    toWorkers.forEach((toWorker) => toWorker.send(message));
  }
}
