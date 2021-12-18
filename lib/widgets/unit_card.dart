import 'package:flutter/material.dart';
import 'package:malory/classes/unit.dart';
import 'package:malory/services/subclass_icons_icons.dart';
import 'package:malory/utils.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({
    Key? key,
    required this.unit,
  }) : super(key: key);

  final Unit unit;

  static const limit = 9;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.all(convert(10)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Icon(
                      SubclassIcons.getIcon(unit.subclass),
                      size: convert(32),
                      color: Colors.white,
                    ),
                    Text(
                      unit.category.substring(
                          0, unit.category.startsWith("Merc") ? 4 : 3),
                    ),
                  ],
                ),
                SizedBox(
                  width: convert(10),
                ),
                Flexible(
                  child: Text(
                    unit.name,
                    style: unit.name.length > limit
                        ? Theme.of(context).textTheme.subtitle1
                        : Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            ),
            SizedBox(
              height: convert(10),
            ),
            Flexible(
              child: Text(
                unit.description.replaceAll("\n", ""),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white.withAlpha(191)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
