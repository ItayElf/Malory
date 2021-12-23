import 'package:flutter/material.dart';
import 'package:malory/services/client.dart';
import 'package:malory/utils.dart';
import 'package:malory/widgets/jumping_swords.dart';

class UnitSelectionScreen extends StatelessWidget {
  const UnitSelectionScreen({Key? key}) : super(key: key);

  void quitRoom(BuildContext context) async {
    Client.handleExceptions(
      context,
      () async {
        await Client.leaveRoom();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff0d0d0d), Color(0xff013a40), Color(0xff0d0d0d)],
            ),
          ),
          child: StreamBuilder(
            initialData: false,
            stream: Client.isGameReady(),
            builder: (context, AsyncSnapshot<bool> snapshot) => Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: convert(64),
                      ),
                      onTap: () {
                        quitRoom(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        Client.room,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                snapshot.data == true
                    ? Container()
                    : const Expanded(child: _Waiting()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Waiting extends StatelessWidget {
  const _Waiting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const JumpingSwords(swords: 3),
          Text(
            "Waiting for opponent...",
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
