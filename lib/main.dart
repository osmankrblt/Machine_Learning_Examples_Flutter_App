import 'package:flutter/material.dart';
import 'package:machine_learning_example_app/FileSelect.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

import 'methodSelect.dart';

void main() async {
  runApp(const MyApp());
  DefaultCacheManager().emptyCache();
  final cacheDir = await getTemporaryDirectory();
  cacheDir.deleteSync(recursive: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Machine Learning App',
      home: const MethodSelectPage(),
    );
  }
}
