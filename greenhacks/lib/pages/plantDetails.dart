import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:greenhacks/api/Plant.dart';
import 'package:greenhacks/size_config.dart';

class PlantDetails extends StatefulWidget {
  final File file;

  PlantDetails(this.file);

  @override
  _PlantDetailsState createState() => _PlantDetailsState(this.file);
}

class _PlantDetailsState extends State<PlantDetails> {
  File _file;
  var response;
  var commonName= '';
  var scientificName='';
  var description='';
  var source='';

  _PlantDetailsState(this._file);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlantData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.green,
        Colors.white,
      ], begin: Alignment.topLeft, end: FractionalOffset(1, 1))),
      child: Scaffold(
        appBar: appBar(),
        body: body(),
      ),
    );
  }

  appBar() {
    return AppBar(
      title: Text('Plant Details'),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageContainer(),
            SizedBox(
              height: 20,
            ),
            Text("Common Name:",style: TextStyle(fontFamily: 'Ubuntu'),),
            SizedBox(height: 10,),
            _PlantName(commonName),
          SizedBox(height: 20,),
            Text('Scientific Name:',style: TextStyle(fontFamily:'Ubuntu'),),
            SizedBox(height: 10,),
            _scientificName(scientificName),
            SizedBox(height:20),
            Text('Description:',style: TextStyle(fontFamily: 'Ubuntu'),),
            SizedBox(height: 10,),
            _description(description),
            SizedBox(height: 20,),
            //Text('Source:'),
            // _sourceLink('www.wikipaedia.com'),
          ],
        ),
      ),
    );
  }

  _imageContainer() {
    return Center(
      child: CircleAvatar(
        radius: 70,
        backgroundImage: FileImage(_file),
      ) ,
      );
  }

  _PlantName(String s) {
    return Text(
      "$s",
      style: TextStyle(fontSize: 20,fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
    );
  }

  _scientificName(String s) {
    return Text(
      "$s",
      style: TextStyle(fontSize: 20,fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
    );
  }

  _description(String s) {
    return Text(
      s,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.bold
      ),
    );
  }

  Future<void> initPlantData() async {
    String _img = base64Encode(_file.readAsBytesSync());
    Plant plant = Plant(_img);
    var res = await plant.apiCall(plant);
    setState(() {
      response = res;
      commonName = checkName(response );
      scientificName = checkScientificName(response);
      description = checkDescription(response);
    });
  }

  String checkName(response){
    if(response['plant_details'][commonName]!=null){
      if(response['plant_details'][commonName][0]!=null)
        return response['plant_details'][commonName][0];
    }
    return 'Data Not Found';
  }
  String checkScientificName(response){
    if(response['plant_name']!=null){
        return response['plant_name'];
    }
    return 'Data Not Found';
  }
  String checkDescription(response){
    if(response['plant_details']['wiki_description']!=null){
      if(response['plant_details']['wiki_description']['value']!=null)
        return response['plant_details']['wiki_description']['value'];
    }
    return 'Data Not Found';
  }



}
