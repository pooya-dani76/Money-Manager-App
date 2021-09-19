import 'package:flutter/material.dart';
import 'package:money_manager_ap/Deteminers.dart';

class GetFormField extends StatefulWidget {
  final String lebelText;
  final String keyboardType;
  final Widget prefixIcon;
  final Function onTap;
  final bool expands;
  final TextEditingController controller;
  const GetFormField(
      {Key key,
      this.lebelText,
      this.prefixIcon,
      this.onTap,
      this.keyboardType,
      this.expands,
      this.controller})
      : super(key: key);

  @override
  _GetFormFieldState createState() => _GetFormFieldState();
}

class _GetFormFieldState extends State<GetFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, right: 20, left: 20),
      child: Form(
        child: TextFormField(
          keyboardType: inputType[widget.keyboardType],
          maxLines: widget.expands ? null : 1,
          controller: widget.controller,
          decoration: InputDecoration(
              labelText: widget.lebelText,
              prefixIcon: widget.prefixIcon,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
