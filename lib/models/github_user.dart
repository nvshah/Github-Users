import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GithubUser with ChangeNotifier{
  final String name;
  final String avatar;
  bool isBookmarked;
  final int followers;
  final int followings;
  final int gists;

  GithubUser({
    @required this.name,
    @required this.avatar,
    this.followers,
    this.followings,
    this.gists,
    this.isBookmarked = false,
  });
  
  //Update the bookmark value per User
  void toogleBookmarkValue() {
    isBookmarked = !isBookmarked;
    notifyListeners();
  }
}
