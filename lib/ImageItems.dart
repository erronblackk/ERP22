
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/CameraCaption.dart';
import 'package:untitled/Database.dart';
import 'package:untitled/ParsingItems.dart';
import 'package:untitled/ProviderData.dart';
import 'package:camera/camera.dart';


class ImageItems extends StatefulWidget {

  @override
  _ImageItems createState() => _ImageItems();

   // List data  ;

  // ImageItems( {required this.data}
}
class _ImageItems extends State<ImageItems> {
  // Map<String ,dynamic> res ={};
  late List<CameraDescription> _cameras;
  @override
  Widget build(BuildContext context) {
    // GetAllSpareParts();
    // print(widget.Item_Name + ':' + widget.Item_Code );

    print('ImageItemWidget ');
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Flexible(child:

                Consumer<ProviderData>(
                  builder: (context, data, child) {
                    return ListView.builder(itemCount: data.datalist.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(child: GestureDetector(
                                      onTap: () {
                                        CameraRun();
                                      },
                                      child: Container(
                                          width: 150,
                                          height: 120,
                                          child: Consumer<ProviderData>(
                                            builder: (context, data, child) {
                                              return Image.network(
                                                  'http://192.168.21.36:8088/ApiRouter/StoreProject${ParsingItems
                                                      .fromJson(
                                                      data.datalist[index])
                                                      .IMAGE}');
                                            },
                                          )
                                      )
                                  )
                                    //   // child: Image.network('http://192.168.20.51:8088/ApiRouter/StoreProject/SparePartImage/BMKR/B-BMKR-011.jpg')),
                                  ),
                                  Flexible(child: Column(
                                    children: <Widget>[
                                      SizedBox(child: Consumer<ProviderData>(
                                          builder: (context, data, child) {
                                            return Text('${ParsingItems
                                                .fromJson(data.datalist[index])
                                                .ITEM_CODE}');
                                          }
                                      ),
                                      ),
                                      SizedBox(
                                          child: Consumer<ProviderData>(
                                              builder: (context, data, child) {
                                                // return Text('${ParsingItems.fromJson(widget.data[index]).ITEM_NAME}' );
                                                return Text('${ParsingItems
                                                    .fromJson(
                                                    data.datalist[index])
                                                    .ITEM_NAME}');
                                              }
                                          )
                                      )
                                    ],

                                  )
                                  ),


                                  // ListTile(
                                  //   leading: Image.network('${ParsingItems.fromJson(data[index]).IMAGE}'),
                                  // ))

                                ],
                              ),
                            ),

                          );
                        }
                    );
                  },
                ),


                )
              ],
            )
        )
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<ProviderData>(context, listen: false).dispose();
  }


// GetAllSpareParts()async{
//    Map<String , dynamic> map = new Map();
//        map['MachineName'] = widget.Item_Code;
//        map['PartNumber'] = widget.Item_Name ;
//
//   var dio = Dio();
//   try{
//     Response DioResponse = await dio.get('http://192.168.20.51:8088/apiRouter/SparePartByMachineNameandPartNumber', queryParameters: map);
//    //  print(DioResponse);
//    //  print(ParsingItems.fromJson(data[0]).ITEM_CODE);
//
//     setState((){
//       // data = DioResponse.data ;
//
//       // Map<String , dynamic> ResponseMap ={};
//       // List<dynamic> list = DioResponse.data ;
//
//       data = DioResponse.data;
//      // print(data);
//       // print(  DioeResponse.extra.keys.toString());
//     });
//
//   }catch(error){
//     print(error);
//   }
//
// }


}










