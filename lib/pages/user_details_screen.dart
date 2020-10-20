import 'package:flutter/material.dart';

import '../models/github_user.dart';

class UserDetailsScreen extends StatelessWidget {
  final GithubUser user;

  UserDetailsScreen({@required this.user});

  Widget userDetailsScreenTitle(BuildContext context, String text) {
    return Container(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget userDetailsScreenText(
      BuildContext context, String title, String text) {
    return Container(
      child: Text(
        '$title : $text',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        children: <Widget>[
          //Image
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(user.avatar, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          //Name
          userDetailsScreenTitle(context, user.name),
          SizedBox(height: 10),
          //Followers
          userDetailsScreenText(context, 'Followers', user.followers.toString()),
          SizedBox(height: 10),
          //Followings
          userDetailsScreenText(context, 'Following', user.followings.toString()),
          SizedBox(height: 10),
          //Gists
          userDetailsScreenText(context, 'Followers', user.gists.toString()),
        ],
      ),
    );
  }
}
