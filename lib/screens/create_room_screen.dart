import 'package:flutter/material.dart';
import 'package:malory/services/client.dart';
import 'package:malory/utils.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController name = TextEditingController();
  final TextEditingController points = TextEditingController();

  void create(BuildContext context) async {
    if (name.text.isEmpty) {
      showSnackBar(context, "Please enter a name for the room");
      return;
    } else if (points.text.isEmpty) {
      showSnackBar(context, "Please enter points for the room");
      return;
    } else {
      try {
        int.parse(points.text);
      } catch (e) {
        showSnackBar(context, "Points can only be an integer");
        return;
      }
    }
    Client.handleExceptions(
      context,
      () async {
        await Client.createRoom(name.text, int.parse(points.text));
        Navigator.of(context).pushReplacementNamed("/unit_selection");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Builder(
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width,
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
                          " ",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Create Room",
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: convert(30),
                  ),
                  SizedBox(
                    width: convert(400),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: convert(36),
                          ),
                      controller: name,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColor,
                        filled: true,
                        hintText: "Room name",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white.withAlpha(127)),
                        focusColor: Theme.of(context).primaryColorLight,
                        hoverColor: Theme.of(context).primaryColorLight,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: convert(25),
                  ),
                  SizedBox(
                    width: convert(400),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: convert(36),
                          ),
                      controller: points,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColor,
                        filled: true,
                        hintText: "Points",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white.withAlpha(127)),
                        focusColor: Theme.of(context).primaryColorLight,
                        hoverColor: Theme.of(context).primaryColorLight,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: convert(25),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      create(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "Create",
                      style: Theme.of(context).textTheme.headline3,
                    ),
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
