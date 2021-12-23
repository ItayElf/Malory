import 'package:flutter/material.dart';
import 'package:malory/services/subclass_icons_icons.dart';
import 'package:malory/utils.dart';

class JumpingSwords extends StatefulWidget {
  const JumpingSwords({
    Key? key,
    required this.swords,
  }) : super(key: key);

  final int swords;

  @override
  _JumpingSwordsState createState() => _JumpingSwordsState();
}

class _JumpingSwordsState extends State<JumpingSwords>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  final List<Animation<double>> _animations = [];

  int animationDuration = 300;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationControllers.forEach((e) {
      e.dispose();
    });
    super.dispose();
  }

  void _initAnimation() {
    _animationControllers = List.generate(
      widget.swords,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: animationDuration),
      ),
    );
    for (int i = 0; i < widget.swords; i++) {
      _animations.add(Tween<double>(begin: 0, end: convert(-20))
          .animate(_animationControllers[i]));
      _animationControllers[i].addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationControllers[i].reverse();
            if (i != widget.swords - 1) {
              _animationControllers[i + 1].forward();
            }
          }
          if (i == widget.swords - 1 && status == AnimationStatus.dismissed) {
            _animationControllers[0].forward();
          }
        },
      );
    }
    _animationControllers.first.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.swords,
        (index) => AnimatedBuilder(
          animation: _animationControllers[index],
          builder: (context, child) => Container(
            padding: EdgeInsets.all(convert(2.5)),
            child: Transform.translate(
              offset: Offset(0, _animations[index].value),
              child: Icon(
                SubclassIcons.frontline,
                color: Colors.white,
                size: convert(48),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
