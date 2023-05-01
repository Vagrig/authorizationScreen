import 'package:authorization/features/authorization/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'features/authorization/presentation/widgets/my_app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const MyApp());
}

Future<void> initHive() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  registerAdapters();
}

void registerAdapters() {
  Hive.registerAdapter(UserModelAdapter());
}
