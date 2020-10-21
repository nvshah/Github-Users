import 'dart:convert';

import 'package:flutter/foundation.dart';
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

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        return data.map((user) async{
          final followers = getNumericValues(user["followers_url"]);
          final followings = getNumericValues(user["following_url"]);
          final gists = getNumericValues(user["gists_url"]);
          return GithubUser(
            name: user["login"],
            avatar: user["avatar_url"],
            followers: await followers,
            followings: await followings,
            gists: await gists,
          );
        });
      }
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
    return 0;
  }
}
