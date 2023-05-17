class Sentence {
  final int index;
  final List<String> _words;

  Sentence(this.index, this._words);

  List<String> get words => List.from(_words);

  String get text => _words.join(' ');
}
