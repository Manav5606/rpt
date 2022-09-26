class GetChatOrderAutocompleteData {
  GetChatOrderAutocompleteData({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  List<ChatOrderList>? data;

  factory GetChatOrderAutocompleteData.fromJson(Map<String, dynamic> json) =>
      GetChatOrderAutocompleteData(
        error: json["error"],
        msg: json["msg"],
        data: List<ChatOrderList>.from(
            json["data"].map((x) => ChatOrderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChatOrderList {
  ChatOrderList({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory ChatOrderList.fromJson(Map<String, dynamic> json) => ChatOrderList(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
