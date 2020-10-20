import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType()
class User{
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String avatar;
  
  @HiveField(2)
  final String isBookmarked;

  User(this.name, this.avatar, this.isBookmarked);
}