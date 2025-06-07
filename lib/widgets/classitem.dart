class ClassItem {
  final String category;
  final String image;
  final String title;
  final String teacher;
  final String schedule;
  final String location;
  final String price;
  final int participants;
  final int capacity;
  final String description;
  final List<String> learnings;

  ClassItem({
    required this.category,
    required this.image,
    required this.title,
    required this.teacher,
    required this.schedule,
    required this.location,
    required this.price,
    required this.participants,
    required this.capacity,
    required this.description,
    required this.learnings,
  });

  factory ClassItem.fromJson(Map<String, dynamic> json) {
    return ClassItem(
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      teacher: json['teacher'] ?? '',
      schedule: json['schedule'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? '',
      participants: json['participants'] ?? 0,
      capacity: json['capacity'] ?? 0,
      description: json['description'] ?? '',
      learnings: List<String>.from(json['learnings'] ?? []),
    );
  }
}
