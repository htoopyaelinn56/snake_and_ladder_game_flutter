class LobbyPlayerResponse {
  List<Data>? data;
  bool? host;
  int? you;
  LobbyPlayerResponse({this.data, this.host});

  LobbyPlayerResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        // ignore: unnecessary_new
        data!.add(new Data.fromJson(v));
      });
    }
    host = json['host'];
    you = json['you'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['host'] = host;
    data['you'] = you;
    return data;
  }
}

class Data {
  String? name;
  bool? isHost;
  Data({this.name, this.isHost});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isHost = json['is_host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['is_host'] = isHost;

    return data;
  }
}
