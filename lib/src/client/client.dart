import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat/src/message.pb.dart';

import 'args_parser.dart';

main(List<String> args) async {
  String server = parseArgs(args);

  WebSocket socket = await WebSocket.connect(server);
  socket.map((data) => new Message.fromBuffer(data))
      .listen((Message message) => print('${message.sender}: ${message.text}'));

  await for (String line in stdinLines()) {
    Message message = new Message()
      ..text = line;
    socket.add(message.writeToBuffer());
  }
}

Stream stdinLines() => stdin
    .transform(UTF8.decoder)
    .transform(new LineSplitter());