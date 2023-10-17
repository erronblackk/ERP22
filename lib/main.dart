
import 'dart:collection';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:untitled/Database.dart';
import 'Utility.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';



void main() => runApp(MyApp());


extension SplayTreeMultiMapExtension<K, V> on SplayTreeMap<K, List<V>> {
  void add(K key, V value) {
    (this[key] ??= []).add(value);
  }
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World Demo Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home page'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  var title;
  MyHomePage({Key? key, required this.title}) : super(key: key);
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  List  CurrentParameters =[];
  late final String title;
  TextEditingController clearTxt1 = TextEditingController();
  TextEditingController clearTxt2 = TextEditingController();
  var ItemCodeFilter  ;
  var DescFilter  ;
    final  globalKeys = new GlobalKey<FormState>();

  savedKeyDesc(){
   var ItemCodeFilterstate =  globalKeys.currentState;
     ItemCodeFilterstate?.save();
     var DescFilterState = globalKeys.currentState;
         DescFilterState?.save();
       print('$ItemCodeFilter');
   print('$DescFilter');
  }
  @override
  Widget build(BuildContext context) {
    // getdata();
    // test();
    return Scaffold(
            body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child : Form(
                    key: globalKeys,
                  child: Column(
                    children :<Widget>[
                  EasyAutocomplete(
                  suggestions: const ['B-', 'B-BMKR-', 'B-TRMR-', 'B-DECO-', 'B-INKR-', 'B-NECK-', 'B-PINO', 'B-ELEC','B-CUPP-' ,'B-OVER-', 'B-BRCU-','B-VACU-','B-COMP-',
                               'B-SPG-','B-WATT-','B-SPRY-','B-WOMACK-',],
                      cursorColor: Colors.purple,
                      decoration: InputDecoration(

                          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid,
                                width: 1.5
                              )
                          ),

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.purple,
                                  style: BorderStyle.solid
                              )
                          )
                      ),
                      suggestionBuilder: (data) {
                        return Container(
                            margin: EdgeInsets.all(1),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                // color: Colors.purple,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                                data,
                                style: TextStyle(
                                    color: Colors.black
                                )
                            )

                        );

                      },

                    controller: clearTxt1,
                    onChanged: (text){
                      ItemCodeFilter =text! ;
                    },
                    autofocus: false,
        ),
                          SizedBox(height: 10,),
                          // TextFormField(
                          //   controller: clearTxt1,
                          //   onSaved: (text){
                          //     ItemCodeFilter= text;
                          //   },
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     hintText: 'B-',
                          //   ),
                          // ),
                             TextFormField
                              (
                              controller: clearTxt2,
                              onSaved: (text){
                                DescFilter = text!;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Description',
                              ),
                            ),
                    ]
                  )
                  )
                ),

                Padding(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: ElevatedButton(onPressed: () {
                        savedKeyDesc();
                        getRows();

                          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                          //     ListViewItems(KeyFilter: ItemCodeFilter, Desc: DescFilter),fullscreenDialog: true  ,maintainState: true,
                          //     allowSnapshotting: true ));

                      }, child: Text("Search"))),
                      Expanded(child: ElevatedButton(
                          onPressed: () {clearTxt1.clear(); clearTxt2.clear();
                            setState(() {
                              CurrentParameters = [['cleared'],[':']];
                            });
                            }, child: Text("Clear"))),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                   // Flexible(child: StatefullListView(
                   //     ItemCode:ItemCodeFilter ,
                   //     ItemDesc:DescFilter))
                Flexible(child: ListView.builder(
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
                          Text('${CurrentParameters[0][index]}' ,style: TextStyle(height: 1, fontSize: 14)),
                          Text('   '),
                          Flexible(child:Text('${CurrentParameters[1][index]}',  style: TextStyle(height: 1, fontSize: 14),))
                        ],
                      ),
                    ),

                  );
                }))
              ],
            )

        )
    );
  }

  @override
  void initState(){
    super.initState();
     CurrentParameters = [['ready'],[':']]  ;
  }
  @override
  void dispose(){
    super.dispose();
    CurrentParameters = [['removed'],[':']]  ;
  }
  getRows() async {
    List? _futureList =  await Test(ItemCodeFilter , DescFilter);
    print('inside listviewwidget');
    print(_futureList.toString());
    print('EidtText'+":"+ItemCodeFilter);
    print('EidtText'+":"+DescFilter);
    List Data = (await _futureList)!    ;
    print("at rendring");
    print(DescFilter);
    setState(() {
      CurrentParameters = Data ;
      print(CurrentParameters );
    });

  }
  // Future<void> getdata() async {
  //   ByteData data = await rootBundle.load("wissam/SPARE.xlsx");
  //   var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //   var excel = Excel.decodeBytes(bytes);
  //   var Item_Code, Item_Desc, Item_Cost;
  //   print("now start with flutter");
  //   for (var table in excel.tables.keys) {
  //     for (var row in excel.tables[table]!.rows) {
  //       Item_Code = row[0]?.value;
  //       Item_Desc = row[1]?.value;
  //       Item_Cost = row[2]?.value;
  //       if (Item_Code == null) {} else {
  //         print(Item_Code);
  //         print(Item_Desc);
  //         print(Item_Cost);
  //       }
  //     }
  //   }
  // }


}
// AutoComplete
  class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample( {super.key});

  static const List<String> _kOptions = <String>[
  'B-BMKR-',
  'B-TRMR-',
  'B-DECO-',
  'B-INKR-',
  'B-NECK-',
  ];

  @override
  Widget build(BuildContext context) {
  return Autocomplete<String>(
  optionsBuilder: (TextEditingValue textEditingValue) {
  return _kOptions.where((String option) {
  return option.contains(textEditingValue.text.toString());
  });
  },
  onSelected: (String selection) {
  debugPrint('You just selected $selection');
  },
  );

  }

  }
 // //// statefull widget
 //  class StatefullListView extends StatefulWidget {
 //       var  ItemCode  ;
 //      var ItemDesc ;
 //     StatefullListView({required this.ItemCode , required this.ItemDesc});
 //
 //    @override
 //    _StatefullListViewState createState() => _StatefullListViewState();
 //  }
 //  class _StatefullListViewState extends State<StatefullListView>{
 //
 //   List CurrentParameters =[];
 //    getData() async {
 //      List? _futureList =  await Test(widget.ItemCode , widget.ItemDesc);
 //      print('inside listviewwidget');
 //      print(_futureList.toString());
 //      print('EidtText'+":"+widget.ItemCode);
 //      print('EidtText'+":"+widget.ItemDesc);
 //      List Data = (await _futureList)!    ;
 //      print("at rendring");
 //      print(widget.ItemDesc);
 //      setState(() {
 //        CurrentParameters = Data ;
 //        print(CurrentParameters[[0][0]] );
 //      });
 //
 //       }
 //
 //   @override
 //   void initState(){
 //     super.initState();
 //     CurrentParameters = [[],[]]  ;
 //   }
 //
 //   @override
 //   void didUpdateWidget(covariant StatefullListView oldWidget) {
 //     super.didUpdateWidget(oldWidget);
 //     if (widget.ItemCode != oldWidget.ItemCode && widget.ItemDesc != oldWidget.ItemDesc) {
 //       getData();
 //       // setState(() {
 //       //   CurrentParameters =  ;
 //       // });
 //     }else if (widget.ItemCode == oldWidget.ItemCode && widget.ItemDesc != oldWidget.ItemDesc){
 //       getData();
 //     }
 //   }
 //
 //
 //  @override
 //  Widget build(BuildContext context) {
 //
 //    return ListView.builder(
 //        itemCount: CurrentParameters[0].length,
 //        scrollDirection: Axis.vertical,
 //        shrinkWrap: true,
 //        itemBuilder: (BuildContext context , int index){
 //          return Card(
 //            elevation: 5,
 //            child: Padding(
 //              padding: const EdgeInsets.all(8.0),
 //              child: Row(
 //                children: <Widget>[
 //                 Text('${CurrentParameters[0][index]}')     ,
 //                Flexible(child:Text('${CurrentParameters[1][index]}'))
 //
 //                ],
 //              ),
 //            ),
 //
 //          );
 //        }
 //    );
 //  }
 //  @override
 //  State<StatefulWidget> createState() {
 //    // TODO: implement createState
 //    throw UnimplementedError();
 //  }
 //  }




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
  print(list.toString());
  // print(list[0]);
  // print(list[0].isEmpty);
    return list ;

}



Future<SplayTreeMap<String?, List<String?>>> searchforItems() async {
  ByteData data = await rootBundle.load("wissam/ERP.xlsx");
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
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      try {
        Item_Code1 = row[0]?.value.toString();
        Item_Desc1 = row[1]?.value.toString();
        // Item_Cost1 = row[2]?.value.toString();
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



class GlobalKeys{
  // static final   ItemCodeGlobalKey = GlobalKey() ;
  // static final  DescGlobalKey = GlobalKey() ;
   static final List<GlobalObjectKey<FormState>> formKeyList = List.generate(10, (index) => GlobalObjectKey<FormState>(index));
    static final riKey1 = const Key('__RIKEY1__');
    static final riKey2 = const Key('__RIKEY2__');
    static final riKey3 = const Key('__RIKEY3__');
  }

enum MenuItem {
  item1
}









