import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../constants.dart';
import '../../../utils.dart';
import '../domain/lobby_player_response.dart';

final webSocketProvider = Provider.autoDispose<WebSocketChannel>((ref) {
  final wsUrl = Uri.parse(Utils.isMobileDevice() ? '${Utils.getWebsocketHostUrl(isLocal: true)}/lobby' : '$kWsUrl/lobby');
  final channel = WebSocketChannel.connect(wsUrl);
  ref.onDispose(() => channel.sink.close());
  return channel;
});

final listenLobbySocketProvider = StreamProvider.autoDispose<LobbyPlayerResponse>((ref) async* {
  final channel = ref.watch(webSocketProvider);
  ref.onDispose(() => channel.sink.close());

  await for (final i in channel.stream.asBroadcastStream()) {
    yield LobbyPlayerResponse.fromJson(jsonDecode(i));
  }
});
