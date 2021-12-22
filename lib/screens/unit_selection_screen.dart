import 'package:flutter/material.dart';
import 'package:malory/services/client.dart';
import 'package:malory/utils.dart';

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
            builder: (context, snapshot) => Container(
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
