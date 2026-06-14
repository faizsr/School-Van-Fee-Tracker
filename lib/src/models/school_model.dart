class SchoolModel {
  final String id;
  final String name;

  SchoolModel({required this.id, required this.name});

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(id: json['_id'], name: json['name']);
  }

  SchoolModel copyWith({
    String? id,
    String? name,
  }) {
    return SchoolModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
