class Topic {
  int id = 0;
  String NameTopic = '';

  Topic(this.id, this.NameTopic);

  Topic.empty() {
    this.id = 0;
    this.NameTopic = '';
  }

  @override
  String toString() {
    return ' Id = $id, NameTopic = $NameTopic ';
  }
}
