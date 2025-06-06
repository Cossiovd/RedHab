class ClassItem {
  final String title;
  final String teacher;
  final String schedule;
  final String image;
  final String location;
  final String price;
  final String participants;
  final String description;
  final List<String> learnings;

  ClassItem({
    required this.title,
    required this.teacher,
    required this.schedule,
    required this.image,
    required this.location,
    required this.price,
    required this.participants,
    required this.description,
    required this.learnings,
  });

  factory ClassItem.fromJson(Map<String, dynamic> json) {
    return ClassItem(
      title: json['title'] ?? '',
      teacher: json['teacher'] ?? '',
      schedule: json['schedule'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? '',
      participants: json['participants'] ?? '',
      description: json['description'] ?? '',
      learnings: List<String>.from(json['learnings'] ?? []),
    );
  }
}
