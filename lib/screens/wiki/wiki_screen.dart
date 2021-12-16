import 'package:flutter/material.dart';
import 'package:malory/utils.dart';

class Wiki extends StatelessWidget {
  const Wiki({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Material(
        child: Builder(builder: (context) {
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
            child: Stack(
              children: [
                Positioned(
                  top: convert(40),
                  left: convert(40),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: convert(64),
                    ),
                    onTap: Navigator.of(context).pop,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Wiki",
                          style: Theme.of(context).textTheme.headline1,
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
                            Navigator.of(context).pushNamed("/units");
                          },
                          child: Text(
                            "Units",
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
                          onPressed: () {},
                          child: Text(
                            "Attributes",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
