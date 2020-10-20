import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/github_user.dart';

class DataCacheService{
  final SharedPreferences sharedPreferences;

  DataCacheService({@required this.sharedPreferences});

  Future<void> saveData(List<GithubUser> githubBookmarkedUsers){
    }
  }