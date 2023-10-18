
import 'dart:collection';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

import 'package:untitled/ListView.dart';

// extension SplayTreeMultiMapExtension<K, V> on SplayTreeMap<K, List<V>> {
//   void add(K key, V value) {
//     (this[key] ??= []).add(value);
//   }
// }

class Utility {
  //  Return  all Values  and Keys by passing a SpecificItem-code
   SearchForKeyValue(SplayTreeMap<String? , List<String?>> AllItemsMap , String KeyFilter ) async {
     print("searchkeyvalue");
      for(var map in AllItemsMap.entries){
        if(map.key!.contains(KeyFilter.toUpperCase())){
        print( map.key! +' '+ map.value[0]!)  ;

        }
      }
}
   // return a ItemCode and Values  using Partialy Part Number
   SearchForValue(SplayTreeMap<String? , List<String?>> AllItemsMap , String PartNumber ) async {
     print("searchvalue");
     for(var map in AllItemsMap.entries){
       if(map.value.first!.toUpperCase().contains(PartNumber.toUpperCase())){
         print(map.key! + ' - ' +map.value[0]! )  ;
       }
     }
   }
 SearchWith2Factor(SplayTreeMap<String? , List<String?>> AllItemsMap, String MachineName , String description) async{
     print('function3');
     final newMap = SplayTreeMap();
     for(var map in AllItemsMap.entries){
       if(map.key!.contains(MachineName)&&map.value.first!.contains(description.toUpperCase())){
         print(map.key! + ' - ' +map.value[0]! );

       }
     }
    }

   SearchWith2Factor2(SplayTreeMap<String? , List<String?>> AllItemsMap, String MachineName , String description) async{
     print('function3');
     var keys = [];
     var values = [];
     // List list=[] ;
     for(var map in AllItemsMap.entries){
       if(map.key!.contains(MachineName)&&map.value.first!.toLowerCase().contains(description.toLowerCase())){
         print(map.key! + ' - ' +map.value[0]! );
           // list.add(map.key! + '   :'+ map.value[0]!);
        keys.add(map.key );
        values.add(map.value[0]);

       }
       // else if(map.key!.contains(MachineName)&&map.value.first!.contains(description.toUpperCase())){
       //   print(map.key! + ' - ' +map.value[0]! );
       //   // list.add(map.key! + '   :'+ map.value[0]!);
       //   keys.add(map.key );
       //   values.add(map.value[0]);
       // }else if(map.key!.contains(MachineName)&&map.value.first!.contains(description)){
       //   print(map.key! + ' - ' +map.value[0]! );
       //   // list.add(map.key! + '   :'+ map.value[0]!);
       //   keys.add(map.key );
       //   values.add(map.value[0]);
       // }
     }
     return [keys ,values] ;
   }

 /// pick file
 //   pickFile() async {
 //     // opens storage to pick files and the picked file or files
 //     // are assigned into result and if no file is chosen result is null.
 //     // you can also toggle "allowMultiple" true or false depending on your need
 //     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
 //
 //     // if no file is picked
 //     if (result == null) return;
 //
 //     // we get the file from result object
 //     final file = result.files.first;
 //
 //     openFile(file);
 //   }
 //
 //   openFile(PlatformFile file) {
 //     OpenFile.open(file.path);
 //     searchforImportedItems(file.path);
 //   }

   Future<SplayTreeMap<String?, List<String?>>> searchforImportedItems(String? FilePath) async {
     // ByteData data = await rootBundle.load(FilePath.toString());
     // var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
     // var excel = Excel.decodeBytes(bytes);
     var bytes = File(FilePath.toString()).readAsBytesSync();
     var excel = Excel.decodeBytes(bytes);
     var Item_Code_Postion;
     var Item_Desc_position;
     var Item_Cost_position;
     String? Item_Code1 = "";
     String? Item_Desc1 = "";
     String? Item_Cost1 = "";
     print("now start with flutter");
     for (var table in excel.tables.keys) {
       for (var row in excel.tables[table]!.rows) {

         // Item_Code = row.contains("Location") ;
         for(var cell in row){
           if(cell?.value.toString()=="Item"){
             Item_Code_Postion =cell?.colIndex ;
              print(Item_Code_Postion);
             print("found it");
             // Item_Code1 = row[Item_Code_Postion]?.value.toString();
             // print(Item_Code1);

           }else if(cell?.value.toString()=="Item Desc"){
             Item_Desc_position =cell?.colIndex  ;
              print(Item_Desc_position);
             print("found it");
           }
           // else if(cell?.value.toString()=="Cost"){
           //   Item_Cost =cell?.colIndex  ;
           //    print(Item_Cost );
           //   print("found it");
           // }

         }

       }
     }

     final planetsByMass = SplayTreeMap<String?, List<String?>>();
     for (var table in excel.tables.keys) {
       for (var row in excel.tables[table]!.rows) {
         try {
           Item_Code1 = row[Item_Code_Postion]?.value.toString();
           // print(Item_Code1);
           Item_Desc1 = row[Item_Desc_position]?.value.toString();
           // Item_Cost1 = row[2]?.value.toString();
           if (Item_Code1 == null && Item_Desc1 == null &&
               Item_Cost1 == null) {} else {
             // print(Item_Code1);
             // print(Item_Desc1);
             // print(Item_Cost1);
             // ListVlaue.add(Item_Desc1);
             // ListVlaue.add(Item_Cost1);
             planetsByMass.add(Item_Code1, Item_Desc1);
             // planetsByMass.add(Item_Code1, Item_Cost1);
           }
         } catch (err) {
           print(err);
         }
       }
     }
     planetsByMass.forEach((key, value){
       print('$key:$value' );
     });
     return planetsByMass;
   }


  CreateExcelInAsset  (String FileName ){
     var excel = Excel.createExcel();
     excel.save(fileName: FileName);
   }






}
/// not used
SearchMap(SplayTreeMap<String? , List<String?>> AllItemsMap, String MachineName , String description) async{
  print('function3');
  var keys = [];
  var values = [];
  // List list=[] ;
  for(var map in AllItemsMap.entries){
    if(map.key!.contains(MachineName)&&map.value.first!.contains(description.toUpperCase())){
      print(map.key! + ' - ' +map.value[0]! );
      // list.add(map.key! + '   :'+ map.value[0]!);
      keys.add(map.key );
      values.add(map.value[0]);

    }
  }
  return [keys ,values] ;
}




class Items{
  final String ItemCode;

  Items({required this.ItemCode  });
  // @override
  // String toString() {
  //   'Items :$ItemCode';
  //   'Items:$Description';
  //   return super.toString();
  // }
  @override set() =>('ItemCode:$ItemCode');

}
