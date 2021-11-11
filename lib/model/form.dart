import 'package:flutter/foundation.dart';
import 'dart:convert';

class Form {
  final int formid;
  final String formname;
  final String instruction;
  final List<Field> fields;
  final int nextFormId;
  final int cancelFormId;

  Form({
    @required this.formid,
    @required this.formname,
    @required this.instruction,
    @required this.fields,
    this.nextFormId,
    this.cancelFormId,
  });

  factory Form.fromJson(Map<String, dynamic> json) {
    return Form(
      formid: json['formid'] as int,
      formname: json['formname'] as String,
      instruction: json['instruction'] as String,
      fields: json['fields'].forEach((s) {
        return Field.fromJson(s);
      }),
      nextFormId: json['next-form-id'] as int,
      cancelFormId: json['cancel-form-id'] as int,
    );
  }
}

class Field {
  final int fieldId;
  final int fieldOrder;
  final String fieldName;
  final String fieldType;
  final int length;
  final bool mandatory;
  final List<String> contraints;

  Field({
    @required this.fieldId,
    @required this.fieldOrder,
    @required this.fieldName,
    @required this.fieldType,
    this.length,
    this.mandatory,
    this.contraints,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      fieldId: json['field-id'] as int,
      fieldOrder: json['field-order'] as int,
      fieldName: json['field-name'] as String,
      fieldType: json['field-type'] as String,
      length: json['length'] as int,
      mandatory: json['mandatory'] as bool,
      contraints: json['contraints'] as List<String>,
    );
  }
}
/****
{
formid: 1,
formname: 'checkout-1'
instruction: 'Please fill the 
fields:
	[
	{field-id: 1, field-order: 1, field-name: 'Surname', field-type: 'Text', length: 20, mandatory: true, contraints:["Letter"]},
	{field-id: 2, field-order: 2, field-name: 'Given name', field-type: 'Text', length: 20, mandatory: true, contraints:["Letter"]},
	{field-id: 3, field-order: 3, field-name: 'Email', field-type: 'Text', length: 30, mandatory: true, contraints:["Email"]},
	{field-id: 4, field-order: 4, field-name: 'Delivery Addr 1', field-type: 'Text', length: 30, mandatory: true },
	{field-id: 5, field-order: 5, field-name: 'Addr 2', field-type: 'Text', length: 30, },
	{field-id: 6, field-order: 6, field-name: 'Addr 3', field-type: 'Text', length: 30, },
	{field-id: 7, field-order: 7, field-name: 'Country / Region', field-type: 'Auto-complete-dropdown', option-source-page-id: 80, },
	{field-id: 8, field-order: 8, field-name: 'Next', field-type: 'Next', next-form-id: 2, },
	]
next-form-id: 2,
cancel-form-id: 0,
}






 */
