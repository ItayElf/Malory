import 'package:flutter/widgets.dart';

class SubclassIcons {
  SubclassIcons._();

  static const _kFontFam = 'SubclassIcons';
  static const String? _kFontPkg = null;

  static const IconData objective =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData skirmisher =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData support =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData tank =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData artillery =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData charger =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData frontline =
      IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData flanker =
      IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  static IconData getIcon(String subclass) {
    final map = <String, IconData>{
      "Artillery": SubclassIcons.artillery,
      "Charger": SubclassIcons.charger,
      "Flanker": SubclassIcons.flanker,
      "Fronline": SubclassIcons.frontline,
      "Objective": SubclassIcons.objective,
      "Skirmisher": SubclassIcons.skirmisher,
      "Support": SubclassIcons.support,
      "Tank": SubclassIcons.tank,
    };
    if (!map.containsKey(subclass)) {
      return SubclassIcons.frontline;
    }
    return map[subclass] as IconData;
  }
}
