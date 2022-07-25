class Storage {
  final int idx;
  final String title;
  final String content;

  Storage({this.idx, this.title, this.content});

  Map<String, dynamic> toMap() {
    return {
      'idx': idx,
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Storage{idx: $idx, title: $title, content: $content}';
  }
}
