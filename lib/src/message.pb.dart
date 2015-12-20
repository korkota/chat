///
//  Generated code. Do not modify.
///
library server.proto_message;

import 'package:protobuf/protobuf.dart';

class Message extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Message')
    ..a(1, 'sender', PbFieldType.QS)..a(2, 'text', PbFieldType.QS)..a(
        3, 'data', PbFieldType.OS)
  ;

  Message() : super();

  Message.fromBuffer(List<int> i,
      [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);

  Message.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY])
      : super.fromJson(i, r);

  Message clone() => new Message()
    ..mergeFromMessage(this);

  BuilderInfo get info_ => _i;

  static Message create() => new Message();

  static PbList<Message> createRepeated() => new PbList<Message>();

  static Message getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMessage();
    return _defaultInstance;
  }

  static Message _defaultInstance;

  static void $checkItem(Message v) {
    if (v is! Message) checkItemFailed(v, 'Message');
  }

  String get sender => $_get(0, 1, '');

  void set sender(String v) {
    $_setString(0, 1, v);
  }

  bool hasSender() => $_has(0, 1);

  void clearSender() => clearField(1);

  String get text => $_get(1, 2, '');

  void set text(String v) {
    $_setString(1, 2, v);
  }

  bool hasText() => $_has(1, 2);

  void clearText() => clearField(2);

  String get data => $_get(2, 3, '');

  void set data(String v) {
    $_setString(2, 3, v);
  }

  bool hasData() => $_has(2, 3);

  void clearData() => clearField(3);
}

class _ReadonlyMessage extends Message with ReadonlyMessageMixin {}

const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'Sender', '3': 1, '4': 2, '5': 9},
    const {'1': 'Text', '3': 2, '4': 2, '5': 9},
    const {'1': 'Data', '3': 3, '4': 1, '5': 9},
  ],
};

