import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/github_user.dart';

class GithubService {
  //fetch Users from github api
  Future<List<Future<GithubUser>>> getGithubUsers() async {
    final uri = Uri(scheme: 'https', host: 'api.github.com', path: 'users');

    final response = await http.get(
      uri.toString(),
      headers: {'Accept': 'application/json'},
    );
    //print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      //data = [data[0], data[1], data[2]];
      //data = data.sublist(0, 4);   // this will give error as List<dynamic> is not sub type of  List<Map<String, dynamic>>
      //print(data);
      //if(data is List<dynamic>){
        if (data.isNotEmpty) {
        return data.map((user) async{
          //user = user as Map<String, dynamic>;
          //print(user);
          //final additionalData = getadditionalData(user["url"]);
          //final gists = getNumericValues(user["gists_url"]);
          //final values = await Future.wait([additionalData, gists]);
          //print(values);
          return GithubUser(
            name: user["login"],
            avatar: user["avatar_url"],
            //followers: values[0]["followers"],
            //followings: values[0]["following"],
            //gists: values[1],
          );
        }).toList();
      //}
      }
      // //print(data[0]); 
      // return null;
    }
    else if(response.statusCode == 403){
      throw Exception('try after sometime something went wrong');
    }
  }

  //Used to get numeric/statistical values for given user
  Future<int> getNumericValues(String url) async {
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data?.length ?? 0;
    }
    else if(response.statusCode == 403){
      throw Exception('try after sometime something went wrong');
    }
    return 0;
  }

  Future<dynamic> getadditionalData(String url) async{
    //print(url);
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else if(response.statusCode == 403){
      throw Exception('try after sometime something went wrong');
    }
  }
}
