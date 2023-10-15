import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class Database {
     late var database  ;
  // create table
  void Open_DatabaseConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
     database = openDatabase(

        join(await getDatabasesPath(), 'SparePart_database.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE ITEMS(id INT PRIMARY KEY , ItemCode TEXT , ItemName TEXT  )'
          );
        },
      version: 1,
    );
   print('Database created');
   print( await getDatabasesPath()) ;
  }

  Future<void> insertParts(Items items) async {
    //
    final db = await database ;
    await db.insert(
      'Items',
      items.toSplayTreeMap(),
      ConflictAlgorithm :ConflictAlgorithm.replace

    );
  }


     // await database.transaction((txn) async {
     // int id1 = await txn.rawInsert(
     // 'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
     // print('inserted1: $id1');
     // int id2 = await txn.rawInsert(
     // 'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
     // ['another name', 12345678, 3.1416]);
     // print('inserted2: $id2');
     // });


// Future<void> insertrowsInTables() async  {
  //   final db = await database ;
  //   await db.insert(
  //
  //   )
  // }
}
class Items {
  final String ItemCode ;
  final String ItemName ;
  final int Cost ;


  const Items( {
    required this.ItemCode,
    required this.ItemName,
    required this.Cost
  });

  Map<String,dynamic> toSplayTreeMap(){
      return{
        'ItemCode':ItemCode,
        'ItemName':ItemName
      };
  }

}
