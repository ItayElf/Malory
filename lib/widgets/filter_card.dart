import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malory/services/subclass_icons_icons.dart';
import 'package:malory/utils.dart';
import 'package:malory/widgets/drop_tile.dart';

class FilterCard extends StatelessWidget {
  const FilterCard({
    Key? key,
    required this.filter,
    required this.costMin,
    required this.costMax,
    required this.role,
    required this.roles,
    required this.nations,
    required this.nation,
  }) : super(key: key);

  final Function filter;
  final TextEditingController costMin;
  final TextEditingController costMax;
  final TextEditingController role;
  final TextEditingController nation;
  final List<String> roles;
  final List<String> nations;

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
                        value: role.text.isEmpty ? null : role.text,
                        hint: Text(
                          "Select Role",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        dropdownColor: Theme.of(context).primaryColorLight,
                        onChanged: (value) {
                          role.text = value.toString();
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
                    ),
                    DropTile(
                      title: "Nation",
                      child: DropdownButton(
                        value: nation.text.isEmpty ? null : nation.text,
                        hint: Text(
                          "Select Nation",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        dropdownColor: Theme.of(context).primaryColorLight,
                        onChanged: (value) {
                          nation.text = value.toString();
                          filter();
                        },
                        items: [
                          const DropdownMenuItem(
                            child: Text("Any"),
                            value: "Any",
                          ),
                          ...nations
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList()
                        ],
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
