import 'package:malory/classes/attribute.dart';

class Unit {
  Unit.fromJson(Map<String, dynamic> json)
      : category = json["category"],
        name = json["name"],
        description = json["description"],
        clas = json["clas"],
        subclass = json["subclass"],
        cost = json["cost"],
        men = json["men"],
        weight = json["weight"],
        hitpoints = json["hitpoints"],
        armor = json["armor"],
        shield = json["shield"],
        morale = json["morale"],
        speed = json["speed"],
        meleeAttack = json["melee_attack"],
        defense = json["defense"],
        damage = json["damage"],
        ap = json["ap"],
        charge = json["charge"],
        ammunition = json["ammunition"],
        range = json["range"],
        rangedAttack = json["ranged_attack"],
        rangedDamage = json["ranged_damage"],
        rangedAp = json["ranged_ap"],
        attributes = json["attributes"]
            .map<Attribute>((e) => Attribute.fromJson(e))
            .toList(),
        idx = json["idx"];

  String category;
  String name;
  String description;
  String clas;
  String subclass;
  double cost;
  int men;
  double weight;
  int hitpoints;
  int armor;
  double shield;
  int morale;
  int speed;
  int meleeAttack;
  int defense;
  int damage;
  int ap;
  int charge;
  int ammunition;
  int range;
  int rangedAttack;
  int rangedDamage;
  int rangedAp;
  List<Attribute> attributes;
  int idx;

  String get costAsClean => cost.toStringAsFixed(
        cost.truncateToDouble() == cost ? 0 : 1,
      );

  bool hasAttribute(String attribute) =>
      attributes.where((e) => e.name == attribute).length == 1;
}
