import 'package:malory/classes/active_unit.dart';
import 'package:malory/classes/unit.dart';

class Player {
  Player({
    required this.units,
    required this.data,
    required this.name,
    required this.idx,
  });

  Player.fromJson(Map<String, dynamic> json)
      : units = json["units"]
            .map<ActiveUnit>((e) => ActiveUnit.fromJson(e))
            .toList(),
        data = json["data"].map<Unit>((e) => Unit.fromJson(e)).toList(),
        name = json["name"],
        idx = json["idx"];

  List<ActiveUnit> units;
  List<Unit> data;
  String name;
  int idx;

  @override
  String toString() {
    return "Player(name: $name, units: $units, data: $data, idx: $idx)";
  }
}
