import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'user.dart';

class GithubUser with ChangeNotifier {
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

  User toUser() {
    return User(
      this.name,
      this.avatar,
      this.isBookmarked,
    );
  }

  static GithubUser fromUser(User user){
    return GithubUser(
      name: user.name,
      avatar: user.avatar,
      isBookmarked: true,
    );
  }
}
