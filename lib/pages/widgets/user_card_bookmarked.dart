import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../models/user.dart';
import '../../data/github_store.dart';

class UserCardBookMarked extends StatelessWidget {
  final User user;

  UserCardBookMarked(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      //User-Card Item
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: GestureDetector(
            //Navigate to details page
            // onTap: () => Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => UserDetailsScreen(
            //       user: user,
            //     ),
            //   ),
            // ),
            onTap: (){},
            child: ListTile(
              //Image
              leading: CircleAvatar(
                radius: 30,
                child: Image.network(
                  user.avatar,
                  fit: BoxFit.cover,
                ),
              ),
              //Name
              title: Text(
                user.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              //bookmark
              trailing: IconButton(
                  icon: Icon(Icons.bookmark),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    //TODO Bookmark Toggling Logic
                    Injector.get<GithubStore>().toggleBookMark(user.name);
                    
                    //reflect changes locally
                    final githubBox = Hive.box('github');
                    githubBox.delete(user.name);
                  },
              ),
            ),
          ),
        ),
      ),
    );
  }
}