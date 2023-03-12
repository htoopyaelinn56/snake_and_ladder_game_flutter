class GameDiceResponse {
  int? currentTurn;
  int? diceNum;
  bool? canStart;

  GameDiceResponse({this.currentTurn, this.diceNum, this.canStart});

  GameDiceResponse.fromJson(Map<String, dynamic> json) {
    currentTurn = json['current_turn'];
    diceNum = json['dice_num'];
    canStart = json['can_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_turn'] = this.currentTurn;
    data['dice_num'] = this.diceNum;
    data['can_start'] = this.canStart;
    return data;
  }
}
