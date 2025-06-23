import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'list_kontak.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
 
void main() {
  runApp(const MyApp());
 
  sqflite_ffi.sqfliteFfiInit();
 
  databaseFactory = sqflite_ffi.databaseFactoryFfi;
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite Flutter',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const ListKontakPage(),
    );
  }
}
 