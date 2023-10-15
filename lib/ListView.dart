import 'dart:collection';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'Utility.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';

extension SplayTreeMultiMapExtension<K, V> on SplayTreeMap<K, List<V>> {
  void add(K key, V value) {
    (this[key] ??= []).add(value);
  }
}

class StatefullListView extends StatefulWidget {
  var  ItemCode  ;
  var ItemDesc ;
  StatefullListView({required this.ItemCode , required this.ItemDesc});

  @override
  _StatefullListViewState createState() => _StatefullListViewState();
}
class _StatefullListViewState extends State<StatefullListView>{

  List CurrentParameters =[];
  getData() async {
    List? _futureList =  await Test(widget.ItemCode , widget.ItemDesc);
    print('inside listviewwidget');
    print(_futureList.toString());
    print('EidtText'+":"+widget.ItemCode);
    print('EidtText'+":"+widget.ItemDesc);
    List Data = (await _futureList)!    ;
    print("at rendring");
    print(widget.ItemDesc);
    setState(() {
      CurrentParameters = Data ;
      print(CurrentParameters[[0][0]] );
    });

  }

  @override
  void initState(){
    super.initState();
    CurrentParameters = [[],[]]  ;
  }

  @override
  void didUpdateWidget(covariant StatefullListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.ItemCode != oldWidget.ItemCode && widget.ItemDesc != oldWidget.ItemDesc) {
      getData();
      // setState(() {
      //   CurrentParameters =  ;
      // });
    }else if (widget.ItemCode == oldWidget.ItemCode ){
      getData();
    }
  }


  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: CurrentParameters[0].length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context , int index){
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text('${CurrentParameters[0][index]}')     ,
                  Flexible(child:Text('${CurrentParameters[1][index]}'))

                ],
              ),
            ),

          );
        }
    );
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

Future<List?> Test(String KeyFilter , String Desc ) async {
  print("function teeest");
  SplayTreeMap<String?, List<String?>> m = await searchforItems();
  Utility utility = Utility();
  var list = [];
  //await utility.SearchForKeyValue( m , 'B-BMKR-');
  //  await utility.SearchForValue(m, 'sensor');
  // utility.SearchWith2Factor(m, KeyFiltr, Desc );
  list = await utility.SearchWith2Factor2(m, KeyFilter, Desc );
  print('List of Test');
  // print(list[0]);
  // print(list[0].isEmpty);
  return list ;

}

Future<SplayTreeMap<String?, List<String?>>> searchforItems() async {
  ByteData data = await rootBundle.load("wissam/SPARE.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  var Item_Code;
  var Item_Desc;
  var Item_Cost;
  print("now start with flutter");
  var Item_List = [];
  // for (var table in excel.tables.keys) {
  //   for (var row in excel.tables[table]!.rows) {
  //
  //     // Item_Code = row.contains("Location") ;
  //     for(var cell in row){
  //       if(cell?.value.toString()=="Item"){
  //         Item_Code =cell?.colIndex ;
  //          print(Item_Code);
  //         print("found it");
  //       }else if(cell?.value.toString()=="Item Desc"){
  //         Item_Desc =cell?.colIndex  ;
  //          print(Item_Desc);
  //         print("found it");
  //       }else if(cell?.value.toString()=="Cost"){
  //         Item_Cost =cell?.colIndex  ;
  //          print(Item_Cost );
  //         print("found it");
  //       }
  //
  //     }
  //
  //   }
  // }

  final planetsByMass = SplayTreeMap<String?, List<String?>>();


  String? Item_Code1 = "";
  String? Item_Desc1 = "";
  String? Item_Cost1 = "";
  List<String?> ListVlaue = <String?>[];
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      try {
        Item_Code1 = row[0]?.value.toString();
        Item_Desc1 = row[1]?.value.toString();
        Item_Cost1 = row[2]?.value.toString();
        if (Item_Code1 == null && Item_Desc1 == null &&
            Item_Cost1 == null) {} else {
          // print(Item_Code1);
          // print(Item_Desc1);
          // print(Item_Cost1);
          // ListVlaue.add(Item_Desc1);
          // ListVlaue.add(Item_Cost1);
          planetsByMass.add(Item_Code1, Item_Desc1);
          planetsByMass.add(Item_Code1, Item_Cost1);
        }
      } catch (err) {
        print(err);
      }
    }
  }
  // planetsByMass.forEach((key, value){
  //   print('$key:$value' );
  // });
  return planetsByMass;
}