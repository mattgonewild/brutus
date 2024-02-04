//
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use workerTypeDescriptor instead')
const WorkerType$json = {
  '1': 'WorkerType',
  '2': [
    {'1': 'COMBINATION', '2': 0},
    {'1': 'PERMUTATION', '2': 1},
    {'1': 'DECRYPTION', '2': 2},
  ],
};

/// Descriptor for `WorkerType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List workerTypeDescriptor = $convert.base64Decode(
    'CgpXb3JrZXJUeXBlEg8KC0NPTUJJTkFUSU9OEAASDwoLUEVSTVVUQVRJT04QARIOCgpERUNSWV'
    'BUSU9OEAI=');

@$core.Deprecated('Use budgetDescriptor instead')
const Budget$json = {
  '1': 'Budget',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'balance', '3': 2, '4': 1, '5': 1, '10': 'balance'},
  ],
};

/// Descriptor for `Budget`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List budgetDescriptor = $convert.base64Decode(
    'CgZCdWRnZXQSOAoJdGltZXN0YW1wGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcF'
    'IJdGltZXN0YW1wEhgKB2JhbGFuY2UYAiABKAFSB2JhbGFuY2U=');

@$core.Deprecated('Use requestDescriptor instead')
const Request$json = {
  '1': 'Request',
  '2': [
    {'1': 'add', '3': 1, '4': 1, '5': 8, '10': 'add'},
    {'1': 'element', '3': 2, '4': 1, '5': 11, '6': '.brutus.Element', '10': 'element'},
  ],
};

/// Descriptor for `Request`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDescriptor = $convert.base64Decode(
    'CgdSZXF1ZXN0EhAKA2FkZBgBIAEoCFIDYWRkEikKB2VsZW1lbnQYAiABKAsyDy5icnV0dXMuRW'
    'xlbWVudFIHZWxlbWVudA==');

@$core.Deprecated('Use elementDescriptor instead')
const Element$json = {
  '1': 'Element',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Element`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List elementDescriptor = $convert.base64Decode(
    'CgdFbGVtZW50Eg4KAmlkGAEgASgJUgJpZBIUCgV2YWx1ZRgCIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use combinationDescriptor instead')
const Combination$json = {
  '1': 'Combination',
  '2': [
    {'1': 'elements', '3': 1, '4': 3, '5': 11, '6': '.brutus.Element', '10': 'elements'},
  ],
};

/// Descriptor for `Combination`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List combinationDescriptor = $convert.base64Decode(
    'CgtDb21iaW5hdGlvbhIrCghlbGVtZW50cxgBIAMoCzIPLmJydXR1cy5FbGVtZW50UghlbGVtZW'
    '50cw==');

@$core.Deprecated('Use permutationDescriptor instead')
const Permutation$json = {
  '1': 'Permutation',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Permutation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List permutationDescriptor = $convert.base64Decode(
    'CgtQZXJtdXRhdGlvbhIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use targetDescriptor instead')
const Target$json = {
  '1': 'Target',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Target`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List targetDescriptor = $convert.base64Decode(
    'CgZUYXJnZXQSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use resultDescriptor instead')
const Result$json = {
  '1': 'Result',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Result`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultDescriptor = $convert.base64Decode(
    'CgZSZXN1bHQSGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIUCgV2YWx1ZRgCIAEoDFIFdmFsdW'
    'U=');

@$core.Deprecated('Use statusDescriptor instead')
const Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 5, '10': 'code'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `Status`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusDescriptor = $convert.base64Decode(
    'CgZTdGF0dXMSEgoEY29kZRgBIAEoBVIEY29kZRIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use workersResponseDescriptor instead')
const WorkersResponse$json = {
  '1': 'WorkersResponse',
  '2': [
    {'1': 'workers', '3': 1, '4': 3, '5': 11, '6': '.brutus.Worker', '10': 'workers'},
  ],
};

/// Descriptor for `WorkersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workersResponseDescriptor = $convert.base64Decode(
    'Cg9Xb3JrZXJzUmVzcG9uc2USKAoHd29ya2VycxgBIAMoCzIOLmJydXR1cy5Xb3JrZXJSB3dvcm'
    'tlcnM=');

@$core.Deprecated('Use workerRequestDescriptor instead')
const WorkerRequest$json = {
  '1': 'WorkerRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `WorkerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workerRequestDescriptor = $convert.base64Decode(
    'Cg1Xb3JrZXJSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use workerResponseDescriptor instead')
const WorkerResponse$json = {
  '1': 'WorkerResponse',
  '2': [
    {'1': 'worker', '3': 1, '4': 1, '5': 11, '6': '.brutus.Worker', '10': 'worker'},
  ],
};

/// Descriptor for `WorkerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workerResponseDescriptor = $convert.base64Decode(
    'Cg5Xb3JrZXJSZXNwb25zZRImCgZ3b3JrZXIYASABKAsyDi5icnV0dXMuV29ya2VyUgZ3b3JrZX'
    'I=');

@$core.Deprecated('Use procResponseDescriptor instead')
const ProcResponse$json = {
  '1': 'ProcResponse',
  '2': [
    {'1': 'proc', '3': 1, '4': 1, '5': 11, '6': '.brutus.Proc', '10': 'proc'},
  ],
};

/// Descriptor for `ProcResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List procResponseDescriptor = $convert.base64Decode(
    'CgxQcm9jUmVzcG9uc2USIAoEcHJvYxgBIAEoCzIMLmJydXR1cy5Qcm9jUgRwcm9j');

@$core.Deprecated('Use cpuResponseDescriptor instead')
const CpuResponse$json = {
  '1': 'CpuResponse',
  '2': [
    {'1': 'cpu', '3': 1, '4': 1, '5': 11, '6': '.brutus.Cpu', '10': 'cpu'},
  ],
};

/// Descriptor for `CpuResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cpuResponseDescriptor = $convert.base64Decode(
    'CgtDcHVSZXNwb25zZRIdCgNjcHUYASABKAsyCy5icnV0dXMuQ3B1UgNjcHU=');

@$core.Deprecated('Use memResponseDescriptor instead')
const MemResponse$json = {
  '1': 'MemResponse',
  '2': [
    {'1': 'mem', '3': 1, '4': 1, '5': 11, '6': '.brutus.Mem', '10': 'mem'},
  ],
};

/// Descriptor for `MemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memResponseDescriptor = $convert.base64Decode(
    'CgtNZW1SZXNwb25zZRIdCgNtZW0YASABKAsyCy5icnV0dXMuTWVtUgNtZW0=');

@$core.Deprecated('Use netResponseDescriptor instead')
const NetResponse$json = {
  '1': 'NetResponse',
  '2': [
    {'1': 'net', '3': 1, '4': 1, '5': 11, '6': '.brutus.Net', '10': 'net'},
  ],
};

/// Descriptor for `NetResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List netResponseDescriptor = $convert.base64Decode(
    'CgtOZXRSZXNwb25zZRIdCgNuZXQYASABKAsyCy5icnV0dXMuTmV0UgNuZXQ=');

@$core.Deprecated('Use uptimeResponseDescriptor instead')
const UptimeResponse$json = {
  '1': 'UptimeResponse',
  '2': [
    {'1': 'uptime', '3': 1, '4': 1, '5': 11, '6': '.brutus.Uptime', '10': 'uptime'},
  ],
};

/// Descriptor for `UptimeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uptimeResponseDescriptor = $convert.base64Decode(
    'Cg5VcHRpbWVSZXNwb25zZRImCgZ1cHRpbWUYASABKAsyDi5icnV0dXMuVXB0aW1lUgZ1cHRpbW'
    'U=');

@$core.Deprecated('Use loadAvgResponseDescriptor instead')
const LoadAvgResponse$json = {
  '1': 'LoadAvgResponse',
  '2': [
    {'1': 'LoadAvg', '3': 1, '4': 1, '5': 11, '6': '.brutus.LoadAvg', '10': 'LoadAvg'},
  ],
};

/// Descriptor for `LoadAvgResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loadAvgResponseDescriptor = $convert.base64Decode(
    'Cg9Mb2FkQXZnUmVzcG9uc2USKQoHTG9hZEF2ZxgBIAEoCzIPLmJydXR1cy5Mb2FkQXZnUgdMb2'
    'FkQXZn');

@$core.Deprecated('Use poolLoadRequestDescriptor instead')
const PoolLoadRequest$json = {
  '1': 'PoolLoadRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
  ],
};

/// Descriptor for `PoolLoadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List poolLoadRequestDescriptor = $convert.base64Decode(
    'Cg9Qb29sTG9hZFJlcXVlc3QSEgoEdHlwZRgBIAEoCVIEdHlwZQ==');

@$core.Deprecated('Use poolLoadResponseDescriptor instead')
const PoolLoadResponse$json = {
  '1': 'PoolLoadResponse',
  '2': [
    {'1': 'load', '3': 1, '4': 1, '5': 1, '10': 'load'},
  ],
};

/// Descriptor for `PoolLoadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List poolLoadResponseDescriptor = $convert.base64Decode(
    'ChBQb29sTG9hZFJlc3BvbnNlEhIKBGxvYWQYASABKAFSBGxvYWQ=');

@$core.Deprecated('Use procDescriptor instead')
const Proc$json = {
  '1': 'Proc',
  '2': [
    {'1': 'cpu', '3': 1, '4': 1, '5': 11, '6': '.brutus.Cpu', '10': 'cpu'},
    {'1': 'mem', '3': 2, '4': 1, '5': 11, '6': '.brutus.Mem', '10': 'mem'},
    {'1': 'net', '3': 3, '4': 1, '5': 11, '6': '.brutus.Net', '10': 'net'},
    {'1': 'uptime', '3': 4, '4': 1, '5': 11, '6': '.brutus.Uptime', '10': 'uptime'},
    {'1': 'loadAvg', '3': 5, '4': 1, '5': 11, '6': '.brutus.LoadAvg', '10': 'loadAvg'},
  ],
};

/// Descriptor for `Proc`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List procDescriptor = $convert.base64Decode(
    'CgRQcm9jEh0KA2NwdRgBIAEoCzILLmJydXR1cy5DcHVSA2NwdRIdCgNtZW0YAiABKAsyCy5icn'
    'V0dXMuTWVtUgNtZW0SHQoDbmV0GAMgASgLMgsuYnJ1dHVzLk5ldFIDbmV0EiYKBnVwdGltZRgE'
    'IAEoCzIOLmJydXR1cy5VcHRpbWVSBnVwdGltZRIpCgdsb2FkQXZnGAUgASgLMg8uYnJ1dHVzLk'
    'xvYWRBdmdSB2xvYWRBdmc=');

@$core.Deprecated('Use cpuDescriptor instead')
const Cpu$json = {
  '1': 'Cpu',
  '2': [
    {'1': 'idle', '3': 1, '4': 1, '5': 4, '10': 'idle'},
    {'1': 'total', '3': 2, '4': 1, '5': 4, '10': 'total'},
  ],
};

/// Descriptor for `Cpu`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cpuDescriptor = $convert.base64Decode(
    'CgNDcHUSEgoEaWRsZRgBIAEoBFIEaWRsZRIUCgV0b3RhbBgCIAEoBFIFdG90YWw=');

@$core.Deprecated('Use memDescriptor instead')
const Mem$json = {
  '1': 'Mem',
  '2': [
    {'1': 'used', '3': 1, '4': 1, '5': 4, '10': 'used'},
    {'1': 'total', '3': 2, '4': 1, '5': 4, '10': 'total'},
    {'1': 'swapUsed', '3': 3, '4': 1, '5': 4, '10': 'swapUsed'},
    {'1': 'swapTotal', '3': 4, '4': 1, '5': 4, '10': 'swapTotal'},
  ],
};

/// Descriptor for `Mem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memDescriptor = $convert.base64Decode(
    'CgNNZW0SEgoEdXNlZBgBIAEoBFIEdXNlZBIUCgV0b3RhbBgCIAEoBFIFdG90YWwSGgoIc3dhcF'
    'VzZWQYAyABKARSCHN3YXBVc2VkEhwKCXN3YXBUb3RhbBgEIAEoBFIJc3dhcFRvdGFs');

@$core.Deprecated('Use netDescriptor instead')
const Net$json = {
  '1': 'Net',
  '2': [
    {'1': 'rx', '3': 1, '4': 1, '5': 4, '10': 'rx'},
    {'1': 'tx', '3': 2, '4': 1, '5': 4, '10': 'tx'},
  ],
};

/// Descriptor for `Net`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List netDescriptor = $convert.base64Decode(
    'CgNOZXQSDgoCcngYASABKARSAnJ4Eg4KAnR4GAIgASgEUgJ0eA==');

@$core.Deprecated('Use uptimeDescriptor instead')
const Uptime$json = {
  '1': 'Uptime',
  '2': [
    {'1': 'duration', '3': 1, '4': 1, '5': 3, '10': 'duration'},
  ],
};

/// Descriptor for `Uptime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uptimeDescriptor = $convert.base64Decode(
    'CgZVcHRpbWUSGgoIZHVyYXRpb24YASABKANSCGR1cmF0aW9u');

@$core.Deprecated('Use loadAvgDescriptor instead')
const LoadAvg$json = {
  '1': 'LoadAvg',
  '2': [
    {'1': 'oneMinute', '3': 1, '4': 1, '5': 1, '10': 'oneMinute'},
    {'1': 'fiveMinutes', '3': 2, '4': 1, '5': 1, '10': 'fiveMinutes'},
    {'1': 'fifteenMinutes', '3': 3, '4': 1, '5': 1, '10': 'fifteenMinutes'},
  ],
};

/// Descriptor for `LoadAvg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loadAvgDescriptor = $convert.base64Decode(
    'CgdMb2FkQXZnEhwKCW9uZU1pbnV0ZRgBIAEoAVIJb25lTWludXRlEiAKC2ZpdmVNaW51dGVzGA'
    'IgASgBUgtmaXZlTWludXRlcxImCg5maWZ0ZWVuTWludXRlcxgDIAEoAVIOZmlmdGVlbk1pbnV0'
    'ZXM=');

@$core.Deprecated('Use workerDescriptor instead')
const Worker$json = {
  '1': 'Worker',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'time'},
    {'1': 'ip', '3': 3, '4': 1, '5': 9, '10': 'ip'},
    {'1': 'type', '3': 4, '4': 1, '5': 14, '6': '.brutus.WorkerType', '10': 'type'},
    {'1': 'proc', '3': 5, '4': 1, '5': 11, '6': '.brutus.Proc', '10': 'proc'},
    {'1': 'ops', '3': 6, '4': 1, '5': 3, '10': 'ops'},
  ],
};

/// Descriptor for `Worker`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workerDescriptor = $convert.base64Decode(
    'CgZXb3JrZXISDgoCaWQYASABKAlSAmlkEi4KBHRpbWUYAiABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUgR0aW1lEg4KAmlwGAMgASgJUgJpcBImCgR0eXBlGAQgASgOMhIuYnJ1dHVz'
    'LldvcmtlclR5cGVSBHR5cGUSIAoEcHJvYxgFIAEoCzIMLmJydXR1cy5Qcm9jUgRwcm9jEhAKA2'
    '9wcxgGIAEoA1IDb3Bz');

