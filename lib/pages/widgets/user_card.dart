import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../models/github_user.dart';
import '../user_details_screen.dart';
import '../../data/github_repo.dart';

class UserCard extends StatelessWidget {
  final int index;
  final bool useCache;

  UserCard({
    this.index,
    this.useCache = false,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GithubUser>(context);
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
                  icon: Icon(user.isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    //TODO Bookmark Toggling Logic
                    //Changes in local repository
                    if(!useCache)
                      user.toogleBookmarkValue();
                    else
                      Provider.of<GithubRepo>(context, listen: false).toggleBookMark(user.name);
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
