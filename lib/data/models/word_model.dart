class WordList {
  int? id;
  String? word;
  String? pos;

  WordList({this.id, this.word, this.pos});

  WordList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    pos = json['pos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['word'] = word;
    data['pos'] = pos;
    return data;
  }
}