import 'package:flutter/material.dart';

class ConfidenceDialogButton extends StatefulWidget {
  final String text;
  final Function onTap;
  final Color color;
  const ConfidenceDialogButton({Key key, this.text, this.onTap, this.color})
      : super(key: key);

  @override
  _ConfidenceDialogButtonState createState() => _ConfidenceDialogButtonState();
}

class _ConfidenceDialogButtonState extends State<ConfidenceDialogButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.fromLTRB(60, 17, 60, 17),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: widget.color, width: 3.0),
          ),
        ),
        onPressed: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: widget.color,
          ),
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
