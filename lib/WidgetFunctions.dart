import 'package:flutter/material.dart';
import 'DataBase/Data.dart';

Widget format(Transaction transcation) {
  return ListTile(
    title: Text(transcation.note),
    trailing: Text(transcation.price.toString()),
  );
}
