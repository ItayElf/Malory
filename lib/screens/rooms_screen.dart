import 'package:flutter/material.dart';
import 'package:malory/classes/room.dart';
import 'package:malory/services/client.dart';
import 'package:malory/services/subclass_icons_icons.dart';
import 'package:malory/utils.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final TextEditingController controller = TextEditingController();
  List<Room> rooms = [];

  @override
  void initState() {
    super.initState();
    Client.availableRooms().then((value) {
      setState(() {
        rooms = value;
      });
    });
  }

  void join(BuildContext context) async {
    Client.handleExceptions(
      context,
      () async {
        await Client.joinRoom(controller.text);
        Navigator.of(context).pushNamed("/unit_selection");
      },
    );
  }

  void create(BuildContext context) async {
    Navigator.of(context).pushNamed("/create_room");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) => Scaffold(
        body: Builder(
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff0d0d0d),
                    Color(0xff013a40),
                    Color(0xff0d0d0d)
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
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
                          "Rooms",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: convert(40),
                  ),
                  SizedBox(
                    width: convert(500),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: convert(15)),
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white.withAlpha(127)),
                              hintText: "Room name",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: convert(10),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColorLight),
                          child: Padding(
                            padding: EdgeInsets.all(convert(5)),
                            child: Text(
                              "Join",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          onPressed: () {
                            join(context);
                          },
                        ),
                        SizedBox(
                          width: convert(5),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColorLight),
                          child: Padding(
                            padding: EdgeInsets.all(convert(5)),
                            child: Text(
                              "Refresh",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          onPressed: () async {
                            List<Room> list = await Client.availableRooms();
                            setState(() {
                              rooms = list;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: convert(20),
                  ),
                  rooms.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Icon(
                                SubclassIcons.frontline,
                                color: Colors.white,
                                size: convert(32),
                              ),
                              SizedBox(
                                height: convert(10),
                              ),
                              Text(
                                "No rooms were found.\nCreate one:",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        )
                      : LimitedBox(
                          maxHeight: convert(300),
                          child: Container(
                            width: convert(550),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: _RoomsTable(
                                key: ValueKey(rooms),
                                availableRooms: rooms,
                                search: controller,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: convert(30),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColorLight),
                    child: Padding(
                      padding: EdgeInsets.all(convert(5)),
                      child: Text(
                        "Create",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    onPressed: () {
                      create(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RoomsTable extends StatefulWidget {
  const _RoomsTable({
    Key? key,
    required this.availableRooms,
    required this.search,
  }) : super(key: key);

  final List<Room> availableRooms;
  final TextEditingController search;

  @override
  State<_RoomsTable> createState() => _RoomsTableState();
}

class _RoomsTableState extends State<_RoomsTable> {
  late List<Room> rooms;

  int _currentSortColumn = 0;
  int _selectedIndex = -1;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    rooms = List.from(widget.availableRooms);
    rooms.sort((a, b) => a.name.compareTo(b.name));
    setSelected();
    widget.search.addListener(setSelected);
  }

  void setSelected() {
    _selectedIndex = -1;
    for (Room room in rooms) {
      if (room.name == widget.search.text) {
        _selectedIndex = rooms.indexOf(room);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    widget.search.removeListener(setSelected);
  }

  void Function(int, bool) sort(int Function(Room, Room) compare) {
    void f(int i, _) {
      Room selected = rooms[_selectedIndex];
      setState(() {
        _currentSortColumn = i;
        rooms.sort(compare);
        if (_isAscending) {
          rooms = rooms.reversed.toList();
        }
        _isAscending = !_isAscending;
        _selectedIndex = rooms.indexOf(selected);
      });
    }

    return f;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle cell =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: convert(15));

    return DataTable(
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isAscending,
      headingRowColor:
          MaterialStateProperty.all(Theme.of(context).primaryColor),
      columns: [
        DataColumn(
          label: Text(
            "name",
            style: Theme.of(context).textTheme.headline5,
          ),
          onSort: sort((a, b) => a.name.compareTo(b.name)),
        ),
        DataColumn(
          label: Text(
            "Host",
            style: Theme.of(context).textTheme.headline5,
          ),
          onSort: sort((a, b) => a.player1.name.compareTo(b.player1.name)),
        ),
        DataColumn(
          label: Text(
            "Points",
            style: Theme.of(context).textTheme.headline5,
          ),
          numeric: true,
          onSort: sort((a, b) => a.points.compareTo(b.points)),
        ),
      ],
      rows: rooms
          .map(
            (e) => DataRow(
              key: ValueKey(e),
              selected: rooms.indexOf(e) == _selectedIndex,
              onSelectChanged: (val) {
                setState(() {
                  if (_selectedIndex != rooms.indexOf(e)) {
                    _selectedIndex = rooms.indexOf(e);
                    widget.search.text = e.name;
                  } else {
                    _selectedIndex = -1;
                    widget.search.text = "";
                  }
                });
              },
              cells: [
                DataCell(
                  Text(
                    e.name,
                    style: cell,
                  ),
                ),
                DataCell(
                  Text(
                    e.player1.name,
                    style: cell,
                  ),
                ),
                DataCell(
                  Text(
                    e.points.toString(),
                    style: cell,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
