import 'package:flutter/material.dart';

class DropTile extends StatelessWidget {
  const DropTile({
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
