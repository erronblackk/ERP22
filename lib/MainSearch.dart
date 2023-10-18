//
// import 'package:dio/dio.dart';
// import 'package:easy_autocomplete/easy_autocomplete.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:untitled/ImageItems.dart';
// import 'package:untitled/ProviderData.dart';
//
//
//
// class MainSearch extends StatefulWidget{
//   @override
//   _MainSearch createState()=> _MainSearch();
//
// }
//
// class _MainSearch extends State<MainSearch>{
//   bool showWidget = true ;
//   final  globalKeys = new GlobalKey<FormState>();
//   TextEditingController clearTxt1 = TextEditingController();
//   TextEditingController clearTxt2 = TextEditingController();
//      String ItemCodeFilter='';
//     String DescFilter ='' ;
//     List data = [];
//   var ItemCodeFilterstate ;
//   var DescFilterState ;
//   // savedKeyDesc(){
//   //    ItemCodeFilterstate =  globalKeys.currentState;
//   //   ItemCodeFilterstate?.save();
//   //    DescFilterState = globalKeys.currentState;
//   //   DescFilterState?.save();
//   //   print('$ItemCodeFilter');
//   //   print('$DescFilter');
//   //   // setState(() {
//   //   //   ItemCodeFilter =ItemCodeFilterstate.toString();
//   //   //   DescFilter= ItemCodeFilter.toString();
//   //   // });
//   // }
//   @override
//     Widget build(BuildContext context){
//
//     return Scaffold(
//         body: Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                     padding: EdgeInsets.all(10),
//                     child : Form(
//                         key: globalKeys,
//                         child: Column(
//                             children :<Widget>[
//                               EasyAutocomplete(
//                                 suggestions: const ['B-', 'B-BMKR-', 'B-TRMR-', 'B-DECO-', 'B-INKR-', 'B-NECK-', 'B-PINO', 'B-ELEC','B-CUPP-' ,'B-OVER-', 'B-BRCU-','B-VACU-','B-COMP-',
//                                   'B-SPG-','B-WATT-','B-SPRY-','B-WOMACK-',],
//                                 cursorColor: Colors.purple,
//                                 decoration: InputDecoration(
//
//                                     contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: BorderSide(
//                                             color: Colors.blue,
//                                             style: BorderStyle.solid,
//                                             width: 1.5
//                                         )
//                                     ),
//
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: BorderSide(
//                                             color: Colors.purple,
//                                             style: BorderStyle.solid
//                                         )
//                                     )
//                                 ),
//                                 suggestionBuilder: (data) {
//                                   return Container(
//                                       margin: EdgeInsets.all(1),
//                                       padding: EdgeInsets.all(5),
//                                       decoration: BoxDecoration(
//                                         // color: Colors.purple,
//                                           borderRadius: BorderRadius.circular(5)
//                                       ),
//                                       child: Text(
//                                           data,
//                                           style: TextStyle(
//                                               color: Colors.black
//                                           )
//                                       )
//
//                                   );
//
//                                 },
//
//                                 controller: clearTxt1,
//                                 onChanged: (text){
//                                   setState(() {
//                                     ItemCodeFilter =text ;
//                                   });
//
//                                 },
//                                 autofocus: false,
//                               ),
//                               SizedBox(height: 10,),
//                               // TextFormField(
//                               //   controller: clearTxt1,
//                               //   onSaved: (text){
//                               //     ItemCodeFilter= text;
//                               //   },
//                               //   decoration: InputDecoration(
//                               //     border: OutlineInputBorder(),
//                               //     hintText: 'B-',
//                               //   ),
//                               // ),
//                               TextFormField
//                                 (
//                                 controller: clearTxt2,
//                                 onSaved: (text){
//                                   setState(() {
//                                     DescFilter = text!;
//                                   });
//
//                                 },
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   hintText: 'Enter Description',
//                                 ),
//                               ),
//                             ]
//                         )
//                     )
//                 ),
//
//                 Padding(
//                   padding: EdgeInsets.all(2),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(child: ElevatedButton(onPressed: () {
//                         // savedKeyDesc();
//                         GetAllSpareParts();
//                         Provider.of<ProviderData>(context , listen: false).SetDatachanged(data);
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ImageItems()));
//                         print('dataMainSearch');
//                         print(data);
//                         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
//                         //     ListViewItems(KeyFilter: ItemCodeFilter, Desc: DescFilter),fullscreenDialog: true  ,maintainState: true,
//                         //     allowSnapshotting: true ));
//
//                       }, child: Text("Search"))),
//                       Expanded(child: ElevatedButton(
//                           onPressed: () {
//                             clearTxt1.clear(); clearTxt2.clear();
//
//                           }, child: Text("Clear"))),
//                     ],
//                   ),
//                 ),
//
//                 SizedBox(height: 10,),
//                 // Flexible(child: StatefullListView(
//                 //     ItemCode:ItemCodeFilter ,
//                 //     ItemDesc:DescFilter))
//
//               ],
//             )
//
//         )
//
//
//     );
//   }
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//
//     });
//   }
//
//   @override
//   void dispose(){
//     super.dispose();
//
//   }
//
//   GetAllSpareParts()async{
//     Map<String , dynamic> map = new Map();
//     map['MachineName'] = ItemCodeFilter;
//     map['PartNumber'] = DescFilter;
//
//     var dio = Dio();
//     try{
//       Response DioResponse = await dio.get('http://192.168.21.36:8088/apiRouter/SparePartByMachineNameandPartNumber', queryParameters: map);
//       //  print(DioResponse);
//       //  print(ParsingItems.fromJson(data[0]).ITEM_CODE);
//       Provider.of<ProviderData>(context , listen: false).SetDatachanged(DioResponse.data);
//       print(DioResponse.data);
//       // setState((){
//       //   data = DioResponse.data;
//       //   print('Insid Dio Method');
//       //   print(data);
//       //   // print(  DioeResponse.extra.keys.toString());
//       // });
//
//     }catch(error){
//       print(error);
//     }
//
//   }
//
// }
//
// class Data{
//   final String Item_Code ;
//   final String Item_Name ;
//   Data({required this.Item_Code , required this.Item_Name});
// }
//
//
//
//
