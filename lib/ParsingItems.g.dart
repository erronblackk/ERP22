// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParsingItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsingItems _$ParsingItemsFromJson(Map<String, dynamic> json) => ParsingItems(
      ID: json['ID'] as int,
      ITEM_CODE: json['ITEM_CODE'] as String,
      ITEM_NAME: json['ITEM_NAME'] as String,
      IMAGE: json['IMAGE'] as String,
    );

Map<String, dynamic> _$ParsingItemsToJson(ParsingItems instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'ITEM_CODE': instance.ITEM_CODE,
      'ITEM_NAME': instance.ITEM_NAME,
      'IMAGE': instance.IMAGE,
    };
