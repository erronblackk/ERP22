import 'package:json_annotation/json_annotation.dart';

part 'ParsingItems.g.dart';
@JsonSerializable(nullable: true)
class ParsingItems {
  final int ID ;
  final String ITEM_CODE ;
  final String ITEM_NAME ;
  final String IMAGE ;
   // List<dynamic> MyResponse ;
  ParsingItems({required this.ID  ,required this.ITEM_CODE ,required this.ITEM_NAME ,required this.IMAGE});
  // factory ParsingItems.fromJson(Map<String , dynamic> json) => _$ParsingItemsFromJson(json);
  factory ParsingItems.fromJson(Map<String , dynamic> json) => ParsingItems(
      ID: json["ID"],
      ITEM_CODE:json["ITEM_CODE"],
      ITEM_NAME:json["ITEM_NAME"],
      IMAGE: json["IMAGE"]
      );

  Map<String, dynamic> toJson() => _$ParsingItemsToJson(this);

  // Map<String , dynamic> MyResponseMap ={};
  // MyResponse.forEach(items){
  //   items.fotEach((key ,value){
  //     MyResponseMap[key] =value;
  //   });
  // }

}