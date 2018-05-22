import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'model/feed.dart';

class ContentList extends StatefulWidget {
  @override
  createState() => _ContentListState();
}

class _ContentListState extends State<ContentList>{

  var _items= [];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() async{
    String dataURL = "https://app.kangzubin.com/iostips/api/feed/list?page=1&from=flutter-app&version=1.0";
    Response response = await get(dataURL);
    //解析数据
    final body = json.decode(response.body);
    final int code = body["code"];
    if(code == 0){
      final feeds = body["data"]["feeds"];//数组

      var items = [];
      feeds.forEach((item) =>
      items.add(Feed(item["author"],item["title"],item["postdate"])));

      setState(() {
        _items = items;
      });
    }
  }

  Widget _buildRow(int i){
    Feed feed = this._items[i];

    return ListTile(
      title: Text(
        feed.title,
        overflow: TextOverflow.fade,
      ),
      subtitle: Text(
       '${feed.postdate} @${feed.author}' ,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("test"), backgroundColor: Colors.red,),
      body: new ListView.builder(
     padding: const EdgeInsets.all(12.0),
     itemCount: _items.length*2,
     itemBuilder: (BuildContext context, int position){
       if(position.isOdd) return Divider();
       final index = position ~/ 2;
       return _buildRow(index);
     },
      ),
    );
  }
}