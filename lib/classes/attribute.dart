class Attribute {
  const Attribute({
    required this.name,
    required this.description,
    required this.idx,
  });

  final String name;
  final String description;
  final int idx;

  Attribute.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"],
        idx = json["idx"];

  @override
  String toString() {
    return "Attribute(name: $name, description: $description, idx: $idx)";
  }
}
