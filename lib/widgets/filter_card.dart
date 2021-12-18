import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malory/classes/unit.dart';
import 'package:malory/services/subclass_icons_icons.dart';
import 'package:malory/utils.dart';
import 'package:malory/widgets/drop_tile.dart';

class FilterCard extends StatefulWidget {
  const FilterCard({
    Key? key,
    required this.setFilterUnits,
    required this.allUnits,
    required this.search,
    required this.roles,
    required this.nations,
    required this.attrs,
  }) : super(key: key);

  final void Function(List<Unit>) setFilterUnits;
  final List<Unit> allUnits;
  final TextEditingController search;
  final List<String> roles;
  final List<String> nations;
  final List<String> attrs;

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  final TextEditingController costMin = TextEditingController();
  final TextEditingController costMax = TextEditingController();

  String role = "";
  String nation = "";
  String classDefense = "";
  String classTag = "";
  String attribute = "";

  void filter() {
    widget.setFilterUnits(widget.allUnits.where(_filter).toList());
    setState(() {});
  }

  bool _filter(Unit e) {
    if (widget.search.text.isNotEmpty &&
        !e.name.toLowerCase().contains(widget.search.text)) {
      return false;
    }
    if (costMin.text.isNotEmpty && e.cost < double.parse(costMin.text)) {
      return false;
    }
    if (costMax.text.isNotEmpty && e.cost > double.parse(costMax.text)) {
      return false;
    }
    if (role.isNotEmpty &&
        role != "Any" &&
        e.subclass.toLowerCase() != role.toLowerCase()) {
      return false;
    }
    if (nation.isNotEmpty &&
        nation != "Any" &&
        e.category.toLowerCase() != nation.toLowerCase()) {
      return false;
    }
    if (classDefense.isNotEmpty &&
        classDefense != "Any" &&
        !e.clas.contains(classDefense)) {
      return false;
    }
    if (classTag.isNotEmpty &&
        classTag != "Any" &&
        !e.clas.contains(classTag)) {
      return false;
    }
    if (attribute.isNotEmpty && !e.hasAttribute(attribute)) {
      return false;
    }
    return true;
  }

  void reset() {
    role = "";
    nation = "";
    classDefense = "";
    classTag = "";
    attribute = "";
    costMax.text = "";
    costMin.text = "";
    widget.search.text = "";
    filter();
  }

  @override
  void initState() {
    super.initState();
    widget.search.addListener(() {
      filter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    DropTile(
                      title: "Cost",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: generateTextFilterField(
                              context,
                              costMin,
                              "Minumum",
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "-",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Flexible(
                            child: generateTextFilterField(
                              context,
                              costMax,
                              "Maximum",
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropTile(
                      title: "Role",
                      child: DropdownButton(
                        value: role.isEmpty ? null : role,
                        hint: Text(
                          "Select Role",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        dropdownColor: Theme.of(context).primaryColorLight,
                        onChanged: (value) {
                          role = value.toString();
                          filter();
                        },
                        items: [
                          DropdownMenuItem(
                            value: "Any",
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
                          ...widget.roles
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
                    ),
                    DropTile(
                      title: "Nation",
                      child: DropdownButton(
                        value: nation.isEmpty ? null : nation,
                        hint: Text(
                          "Select Nation",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        dropdownColor: Theme.of(context).primaryColorLight,
                        onChanged: (value) {
                          nation = value.toString();
                          filter();
                        },
                        items: [
                          const DropdownMenuItem(
                            child: Text("Any"),
                            value: "Any",
                          ),
                          ...widget.nations
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                    DropTile(
                      title: "Class",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: DropdownButton(
                              value: classDefense.isEmpty ? null : classDefense,
                              hint: Text(
                                "Defence",
                                style: Theme.of(context).textTheme.caption,
                              ),
                              dropdownColor:
                                  Theme.of(context).primaryColorLight,
                              onChanged: (String? value) {
                                classDefense = value.toString();
                                filter();
                              },
                              items: [
                                const DropdownMenuItem(
                                  child: Text("Any"),
                                  value: "Any",
                                ),
                                ...["Light", "Medium", "Heavy"].map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: DropdownButton(
                              value: classTag.isEmpty ? null : classTag,
                              hint: Text(
                                "Tag",
                                style: Theme.of(context).textTheme.caption,
                              ),
                              dropdownColor:
                                  Theme.of(context).primaryColorLight,
                              onChanged: (String? value) {
                                classTag = value.toString();
                                filter();
                              },
                              items: [
                                const DropdownMenuItem(
                                  child: Text("Any"),
                                  value: "Any",
                                ),
                                ...["Cavalry", "Infantry", "Ranged"].map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    DropTile(
                      title: "Attribute",
                      child: _AttributeSearchField(
                        attrs: widget.attrs,
                        setAttribute: (value) {
                          attribute = value;
                          filter();
                        },
                      ),
                    ),
                    const Divider(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorLight,
                      ),
                      onPressed: reset,
                      child: Padding(
                        padding: EdgeInsets.all(convert(8)),
                        child: const Text("Reset"),
                      ),
                    )
                  ],
                ),
              )
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

class _AttributeSearchField extends StatelessWidget {
  const _AttributeSearchField(
      {Key? key, required this.attrs, required this.setAttribute})
      : super(key: key);

  final List<String> attrs;
  final void Function(String) setAttribute;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) =>
          TextField(
        controller: controller,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        onChanged: (String value) {
          if (value.isEmpty) {
            setAttribute(value);
          }
        },
        decoration: InputDecoration(
          hintText: "Attribute",
          hintStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white.withAlpha(127)),
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
      ),
      optionsViewBuilder: (context, onSelected, options) => Material(
        color: Theme.of(context).primaryColorLight,
        child: ListView.separated(
          itemBuilder: (context, i) => ListTile(
            onTap: () {
              onSelected(options.elementAt(i));
            },
            tileColor: Theme.of(context).primaryColorLight,
            title: Text(
              options.elementAt(i),
            ),
          ),
          separatorBuilder: (context, i) => Divider(
            color: Theme.of(context).primaryColor,
          ),
          itemCount: options.length,
        ),
      ),
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return attrs.where(
          (e) => e.toLowerCase().contains(
                value.text.toLowerCase(),
              ),
        );
      },
      onSelected: (String selection) {
        setAttribute(selection);
      },
    );
  }
}
