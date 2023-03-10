import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../constants.dart';
import '../../../utils.dart';
import '../domain/lobby_player_response.dart';

final lobbyWebSocketProvider = Provider.autoDispose<WebSocketChannel>((ref) {
  final wsUrl = Uri.parse(Utils.isMobileDevice() ? '${Utils.getWebsocketHostUrl(isLocal: true)}/lobby' : '$kWsUrl/lobby');
  final channel = WebSocketChannel.connect(wsUrl);
  ref.onDispose(() => channel.sink.close());
  return channel;
});

final listenLobbySocketProvider = StreamProvider.autoDispose<LobbyPlayerResponse>((ref) async* {
  final channel = ref.watch(lobbyWebSocketProvider);
  ref.onDispose(() => channel.sink.close());

  await for (final i in channel.stream.asBroadcastStream()) {
    yield LobbyPlayerResponse.fromJson(jsonDecode(i));
  }
});

final gameWebSocketProvider = Provider.autoDispose<WebSocketChannel>((ref) {
  final wsUrl = Uri.parse(Utils.isMobileDevice() ? '${Utils.getWebsocketHostUrl(isLocal: true)}/dice' : '$kWsUrl/dice');
  final channel = WebSocketChannel.connect(wsUrl);
  ref.onDispose(() => channel.sink.close());
  return channel;
});

final listenGameWebSocketProvider = StreamProvider.autoDispose<LobbyPlayerResponse>((ref) async* {
  final channel = ref.watch(gameWebSocketProvider);
  ref.onDispose(() => channel.sink.close());

  await for (final i in channel.stream.asBroadcastStream()) {
    print(i);
  }
});
