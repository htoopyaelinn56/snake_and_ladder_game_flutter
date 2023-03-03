import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../constants.dart';
import '../../../utils.dart';
import '../domain/lobby_player_response.dart';

final listenLobbySocketProvider =
    StreamProvider.autoDispose<LobbyPlayerResponse>((ref) async* {
  final wsUrl = Uri.parse(Utils.isMobileDevice()
      ? 'ws://192.168.100.36:3000/lobby'
      : '$kWsUrl/lobby');
  var channel = WebSocketChannel.connect(wsUrl);

  ref.onDispose(() {
    channel.sink.close();
  });

  await for (final i in channel.stream.asBroadcastStream()) {
    yield LobbyPlayerResponse.fromJson(jsonDecode(i));
  }
});
