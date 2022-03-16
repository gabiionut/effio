class Exercise {
  final int id;
  final String name;
  final String description;
  final String image;
  final String video;
  final String howDescription;
  final String whyDescription;
  final List<String> tags;

  bool isAdded;
  Exercise(this.id, this.name, this.description, this.image, this.video,
      this.howDescription, this.whyDescription, this.isAdded, this.tags);
}
