import 'package:flutter/material.dart';
import 'package:malory/classes/unit.dart';
import 'package:malory/services/client.dart';
import 'package:malory/utils.dart';
import 'package:malory/widgets/unit_card.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({Key? key}) : super(key: key);

  @override
  _UnitsScreenState createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  List<Unit> allUnits = [];
  List<Unit> filteredUnits = [];
  List<String> nations = [];

  @override
  void initState() {
    super.initState();
    () async {
      allUnits = await Client.getAllUnits();
      filteredUnits = List.from(allUnits);
      nations = await Client.getNations();
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
          child: SingleChildScrollView(
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
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          crossAxisSpacing: convert(25),
                          mainAxisSpacing: convert(25),
                          children: filteredUnits
                              .map((e) => UnitCard(unit: e))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        width: convert(300),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
