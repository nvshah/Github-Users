import 'package:flutter/foundation.dart';

import '../models/github_user.dart';
import '../services/github_service.dart';

class GithubRepo{
  List<GithubUser> githubUsers = [];
  final GithubService githubService;

  GithubRepo({@required this.githubService});
  
  //get the list of github users
  Future<void> fetchGithubUsers() async {
    return Future.wait(await githubService.getGithubUsers());
    //githubUsers = await githubService.getGithubUsers();
  }

  void toggleBookMark(String userLogin){
    var user = githubUsers.firstWhere((user) => user.name == userLogin);
    user.toogleBookmarkValue();
  }
}