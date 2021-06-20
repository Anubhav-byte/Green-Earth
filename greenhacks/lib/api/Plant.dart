import 'dart:convert';

import 'package:http/http.dart' as http;
class Plant{
  final String api_key= '';
  String image;
  final String language = 'en';


  Plant(this.image);

  Map<String , dynamic> toJson() => {
    'api_key': api_key,
    'images': [image],
    'plant_language': 'en',
    'plant_details': ['common_names',
      'url',
      'name_authority',
      'wiki_description',
      'taxonomy',
      'synonyms']
  };

  dynamic apiCall(Plant plant) async {
    var client = http.Client();
    var response;
    var data = jsonEncode(plant.toJson());
    try{
      response = await client.post(
          Uri.parse('https://api.plant.id/v2/identify'),
          headers: {
            'Content-Type': 'application/json'
          },
          body: data
      );
    }catch(e){
      print('$e');
    }
    var responseData = jsonDecode(response.body);
    client.close();
    print(responseData);
    return responseData['suggestions'][0];
    //print(responseData);
    // Map<String,dynamic> filteredData = responseData['suggestions'][0];
    // print(filteredData['plant_details']['wiki_description']['value']);
    // print('\n');
    // print('${filteredData['plant_details']['common_names']}  ${filteredData['plant_details']['scientific_name']}');
    //print(responseData['suggestions'][1]);
  }



}
