import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:news/newsscreen/news%20modal.dart';

class News extends GetxController
{
  
  Future<Newsdata> apicall()
  async{
    Uri uri =Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=67c844010f02458987da7721798a7f38");
    var res=await http.get(uri);
    var json=jsonDecode(res.body);
    return Newsdata.fromJson(json);
  }

  void post(String n1,String j1)
  async{
    Uri uri= Uri.parse("https://reqres.in/api/users");
    var res= await http.post(uri,body: {"name":"$n1","job":"$j1"});
    print(res.statusCode);
  }

}