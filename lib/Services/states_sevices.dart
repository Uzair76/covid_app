import 'dart:convert';

import 'package:covid_tracker/Services/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../Models/WorldStatesModel.dart';


class StatesServices{

  Future<WorldStatesModel> fetchWorldStatesRecord() async {

    final response= await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode == 200)
      {
        var data=  jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      }else
        {
          throw Exception(Error);

        }
  }

  Future<List<dynamic>> countryList() async {

    var data;
    final response= await http.get(Uri.parse(AppUrl.countryList));
    if(response.statusCode == 200)
    {
      data=  jsonDecode(response.body);
      return data;
    }else
    {
      throw Exception(Error);

    }
  }
}