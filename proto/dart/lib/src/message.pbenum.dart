//
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class WorkerType extends $pb.ProtobufEnum {
  static const WorkerType COMBINATION = WorkerType._(0, _omitEnumNames ? '' : 'COMBINATION');
  static const WorkerType PERMUTATION = WorkerType._(1, _omitEnumNames ? '' : 'PERMUTATION');
  static const WorkerType DECRYPTION = WorkerType._(2, _omitEnumNames ? '' : 'DECRYPTION');

  static const $core.List<WorkerType> values = <WorkerType> [
    COMBINATION,
    PERMUTATION,
    DECRYPTION,
  ];

  static final $core.Map<$core.int, WorkerType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static WorkerType? valueOf($core.int value) => _byValue[value];

  const WorkerType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
