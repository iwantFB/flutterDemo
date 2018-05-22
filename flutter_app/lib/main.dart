import 'package:flutter/material.dart';
import 'string.dart';
import 'content_list.dart';

class AweSomeHu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.appTitle,
      home: ContentList(),
    );
  }
}

void main() => runApp(new AweSomeHu());

