import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:malory/services/client.dart';
import 'package:malory/utils.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({
    Key? key,
    required this.register,
  }) : super(key: key);

  final bool register;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          message,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }

  Future<void> confirmAction(BuildContext context) async {
    if (username.text.isEmpty) {
      showSnackBar(context, "Enter a username");
      return;
    } else if (password.text.isEmpty) {
      showSnackBar(context, "Enter a password");
      return;
    } else if (password.text.length < 8) {
      showSnackBar(context, "Password needs to be at least 8 characters long");
      return;
    }

    if (register) {
      bool ans = await Client.registerUser(username.text, password.text);
      print(ans);
    } else {
      bool ans = await Client.verifyUser(username.text, password.text);
      print(ans);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
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
                            register ? "Register" : "Login",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: convert(40),
                          ),
                          SizedBox(
                            width: convert(400),
                            child: TextFormField(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: convert(36),
                                  ),
                              controller: username,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).primaryColor,
                                filled: true,
                                hintText: "Username",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Colors.white.withAlpha(127)),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: convert(36),
                                  ),
                              controller: password,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).primaryColor,
                                filled: true,
                                hintText: "Password",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                        color: Colors.white.withAlpha(127)),
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
                            onPressed: () async {
                              await confirmAction(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              "Confirm",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
