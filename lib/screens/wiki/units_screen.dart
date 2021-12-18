import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malory/classes/unit.dart';
import 'package:malory/services/client.dart';
import 'package:malory/services/subclass_icons_icons.dart';
import 'package:malory/utils.dart';
import 'package:malory/widgets/filter_card.dart';
import 'package:malory/widgets/unit_card.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({Key? key}) : super(key: key);

  @override
  _UnitsScreenState createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  List<Unit> allUnits = [];
  List<Unit> filteredUnits = [];
  List<String> roles = [];
  List<String> nations = [];

  final TextEditingController search = TextEditingController();
  final TextEditingController costMin = TextEditingController();
  final TextEditingController costMax = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController nation = TextEditingController();

  @override
  void initState() {
    super.initState();
    () async {
      allUnits = await Client.getAllUnits();
      filteredUnits = List.from(allUnits);
      roles = List.from(allUnits.map((e) => e.subclass).toSet());
      nations = await Client.getNations();
      roles.sort();
      nations.sort();
      setState(() {});
    }();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Material(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff0d0d0d), Color(0xff013a40), Color(0xff0d0d0d)],
            ),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: convert(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: convert(64),
                            ),
                            onTap: Navigator.of(context).pop,
                          ),
                          Expanded(
                            child: Text(
                              "Units",
                              style: Theme.of(context).textTheme.headline1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: convert(25),
                                  ),
                              controller: search,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).primaryColor,
                                filled: true,
                                hintText: "Search",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white.withAlpha(127),
                                      fontSize: convert(25),
                                    ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(convert(8)),
                                  child: Icon(
                                    Icons.search,
                                    size: convert(24),
                                    color: Colors.white,
                                  ),
                                ),
                                focusColor: Theme.of(context).primaryColorLight,
                                hoverColor: Theme.of(context).primaryColorLight,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: convert(300),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: convert(15),
                      ),
                      Row(
                        children: [
                          filteredUnits.isNotEmpty
                              ? Flexible(
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 4,
                                    crossAxisSpacing: convert(25),
                                    mainAxisSpacing: convert(25),
                                    children: filteredUnits
                                        .map((e) => UnitCard(unit: e))
                                        .toList(),
                                  ),
                                )
                              : Expanded(
                                  child: Column(
                                    children: [
                                      Icon(
                                        SubclassIcons.frontline,
                                        color: Colors.white,
                                        size: convert(48),
                                      ),
                                      SizedBox(
                                        height: convert(10),
                                      ),
                                      Text(
                                        "No unit was found",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            width: convert(300),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: convert(15),
                top: convert(95),
                child: FilterCard(
                  setFilterUnits: (List<Unit> units) {
                    setState(() {
                      filteredUnits = units;
                    });
                  },
                  allUnits: allUnits,
                  search: search,
                  roles: roles,
                  nations: nations,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
