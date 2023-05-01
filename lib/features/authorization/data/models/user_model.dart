import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String password;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
  });
}
