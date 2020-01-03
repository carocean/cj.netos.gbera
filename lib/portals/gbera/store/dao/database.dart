import 'dart:async';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../entities.dart';
import 'daos.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Person])
abstract class AppDatabase extends FloorDatabase {
  IUpstreamPersonDAO get upstreamPersonDAO;
}