import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenhacks/api/newsApi.dart';
import 'package:greenhacks/pages/newsDisplay.dart';
import 'package:greenhacks/pages/plantDetails.dart';
import 'package:greenhacks/size_config.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List result = [];
  final picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.green,
        Colors.white,
      ], begin: Alignment.topLeft, end: FractionalOffset(1, 1))),
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          'Explore',
          style: TextStyle(color: Colors.white),
        ),
      ),
      actions: [
        CircleAvatar(
          child: IconButton(
              icon: Icon(
                Icons.upload_file,
                color: Colors.green,
                size: 24,
              ),
              onPressed: () async {
                _getImage(0);
              }),
          backgroundColor: Colors.white,

        ),
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          child: IconButton(
              icon: Icon(
                Icons.camera_alt_rounded,
                color: Colors.green,
              ),
              onPressed: () {
                _getImage(1);
              }),
          backgroundColor: Colors.white,
        ),
        SizedBox(
          width: 17,
        )
      ],
    );
  }

  _body() {
    if(result == null){
      return Text("Nothing to Show");

    }
    return ListView.builder(
        itemCount: result.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 9),
            child: Card(
              borderOnForeground: true,
              semanticContainer: true,
              margin: EdgeInsets.all(8.0),
              color: CupertinoColors.white,
              child: ListTile(
                selectedTileColor: Colors.white,
                title: Text(result[index]['title'], style: TextStyle(fontFamily: 'Ubuntu',fontWeight: FontWeight.bold),),
                onTap: () {

                  var url = result[index]['url'];
                  //print(url);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => NewsDisplay(url)));
                },
              ),
            ),
          );
        });
  }

  Future<void> _getData() async {
    NewsApi newsApi = NewsApi.withFilter('everything', 'green planet');
    List data = await newsApi.getFilteredData();
    if (data == null) {
      print('error');
    } else {
      setState(() {
        result = data;
      });
    }
  }

  Future<void> _getImage(int i) async {
    var pickedfile;
    if(i==0)
        pickedfile = await picker.getImage(source: ImageSource.gallery);
    else
        pickedfile = await picker.getImage(source: ImageSource.camera);

    if(pickedfile != null){
      var file = File(pickedfile.path);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PlantDetails(file))
      );
    }

  }
}
