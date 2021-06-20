import 'dart:convert';

import 'package:http/http.dart' as http;
class NewsApi{
  var rootUrl="https://newsapi.org/v2/";
  final endpoint ;
  var filterUrl = '?q=';
  var filter;
  var apiKey='&apiKey=acf6e5c757284834be6947b35c98bc5a';

  NewsApi(this.endpoint);
  NewsApi.withFilter(this.endpoint,this.filter);

  Future<List> getFilteredData() async {
    final _url = Uri.parse(rootUrl+endpoint+filterUrl+filter+apiKey);
    var client = http.Client();
    var response;
    try{
      response = await client.get(_url);
    }catch(e){
      print(e);
      client.close();
    }


    //print(response.body);
    final data = jsonDecode(response.body);
    List articles = data['articles'];
    client.close();
    return articles;
  }


}