import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../models/github_user.dart';
import '../user_details_screen.dart';

class UserCard extends StatelessWidget {
  final GithubUser user;
  final int index;

  UserCard({
    @required this.user,
    this.index,
  });

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
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(
                    user: user,
                  ),
                )),
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
              trailing: Consumer<GithubUser>(
                builder: (ctxt, user, _) => IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {
                    //TODO Bookmark Toggling Logic
                    user.toogleBookmarkValue();
                    //reflect changes locally
                    final githubBox = Hive.box('github');
                    if (user.isBookmarked)
                      githubBox.add(user);
                    else
                      githubBox.deleteAt(index);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
