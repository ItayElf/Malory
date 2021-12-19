class ActiveUnit {
  ActiveUnit({
    required this.name,
    required this.men,
    required this.morale,
    required this.ammunition,
    required this.idx,
  });

  ActiveUnit.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        morale = json["morale"],
        men = json["men"],
        ammunition = json["ammunition"],
        idx = json["idx"];

  String name;
  int men;
  int morale;
  int ammunition;
  int idx;

  @override
  String toString() {
    return "ActiveUnit(name: $name, morale: $morale, men: $men, ammunition: $ammunition, idx: $idx)";
  }
}
