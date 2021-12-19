import 'package:flutter/material.dart';
import 'package:malory/services/client.dart';
import 'package:malory/utils.dart';

class Lobby extends StatelessWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff0d0d0d), Color(0xff013a40), Color(0xff0d0d0d)],
          ),
        ),
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lobby",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Welcome, ${Client.username}",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: convert(25),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/rooms");
                  },
                  child: Text(
                    "Rooms",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: convert(35),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/wiki");
                  },
                  child: Text(
                    "Wiki",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
