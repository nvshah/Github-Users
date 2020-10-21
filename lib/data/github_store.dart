import 'package:flutter/foundation.dart';

import '../services/github_service.dart';
import '../models/github_user.dart';

class GithubStore{
  final GithubService githubService;

  GithubStore({@required this.githubService});

  List<GithubUser> _githubUsers;

  List<GithubUser> get githubUsers => _githubUsers;

  void getGithubUsers() async {
    _githubUsers = await Future.wait(await githubService.getGithubUsers());
  }

  void toggleBookMark(String userLogin){
    var user = _githubUsers.firstWhere((user) => user.name == userLogin);
    user.isBookmarked = !user.isBookmarked;
  }
}