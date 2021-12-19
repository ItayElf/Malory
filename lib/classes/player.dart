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
        data = {
          for (String key in json["data"].keys)
            key: Unit.fromJson(json["data"][key])
        },
        name = json["name"],
        idx = json["idx"];

  List<ActiveUnit> units;
  Map<String, Unit> data;
  String name;
  int idx;

  @override
  String toString() {
    return "Player(name: $name, units: $units, data: $data, idx: $idx)";
  }
}
