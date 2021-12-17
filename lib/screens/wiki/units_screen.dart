import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malory/classes/unit.dart';
import 'package:malory/services/client.dart';
import 'package:malory/services/subclass_icons_icons.dart';
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
  List<String> roles = [];

  final TextEditingController search = TextEditingController();
  final TextEditingController costMin = TextEditingController();
  final TextEditingController costMax = TextEditingController();
  String? role;

  @override
  void initState() {
    super.initState();
    () async {
      allUnits = await Client.getAllUnits();
      filteredUnits = List.from(allUnits);
      roles = List.from(allUnits.map((e) => e.subclass).toSet());
      roles.sort((a, b) => a.compareTo(b));
      setState(() {});
    }();
  }

  void filter() {
    filteredUnits = allUnits.where(_filter).toList();
    setState(() {});
  }

  bool _filter(Unit e) {
    if (search.text.isNotEmpty && !e.name.toLowerCase().contains(search.text)) {
      return false;
    }
    if (costMin.text.isNotEmpty && e.cost < double.parse(costMin.text)) {
      return false;
    }
    if (costMax.text.isNotEmpty && e.cost > double.parse(costMax.text)) {
      return false;
    }
    if (role != null &&
        role!.isNotEmpty &&
        e.subclass.toLowerCase() != role!.toLowerCase()) {
      return false;
    }
    return true;
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
                              onChanged: (text) {
                                filter();
                              },
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
                child: SizedBox(
                  // color: Colors.red,
                  width: convert(250),
                  height: convert(450),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(convert(8)),
                      child: Column(
                        children: [
                          Text(
                            "Filters",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Expanded(
                              child: ListView(
                            children: [
                              _DropTile(
                                title: "Cost",
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: generateTextFilterField(
                                        context,
                                        costMin,
                                        "Minimum",
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),
                                    Flexible(
                                      child: generateTextFilterField(
                                        context,
                                        costMax,
                                        "Maximum",
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              _DropTile(
                                title: "Role",
                                child: DropdownButton(
                                  value: role,
                                  hint: Text(
                                    "Select Role",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  dropdownColor:
                                      Theme.of(context).primaryColorLight,
                                  onChanged: (String? value) {
                                    setState(() {
                                      role = value ?? "";
                                      filter();
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: "",
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: convert(8),
                                          ),
                                          const Text("Any"),
                                        ],
                                      ),
                                    ),
                                    ...roles
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  SubclassIcons.getIcon(e),
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: convert(8),
                                                ),
                                                Text(e),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField generateTextFilterField(
      BuildContext context, TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      onChanged: (text) {
        filter();
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
        ),
      ],
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Colors.white.withAlpha(127),
            ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withAlpha(127),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _DropTile extends StatelessWidget {
  const _DropTile({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.white,
        ),
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            children: [child],
          ),
        ),
      ],
    );
  }
}
