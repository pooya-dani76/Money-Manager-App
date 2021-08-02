import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SolidAppBar extends StatefulWidget {
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  const SolidAppBar({Key key, this.title, this.actions, this.backgroundColor})
      : super(key: key);

  @override
  _SolidAppBarState createState() => _SolidAppBarState();
}

class _SolidAppBarState extends State<SolidAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Column(
        children: [
          Container(
            height: 24,
            color: widget.backgroundColor,
          ),
          Container(
            height: 56,
            color: widget.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.chevronLeft),
                      iconSize: 18,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: widget.title,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 50,
                      child:widget.actions != null ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widget.actions,
                      ) : null),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
