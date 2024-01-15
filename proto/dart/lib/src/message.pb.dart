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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;

class Budget extends $pb.GeneratedMessage {
  factory Budget({
    $0.Timestamp? timestamp,
    $core.double? balance,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    return $result;
  }
  Budget._() : super();
  factory Budget.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Budget.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Budget', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<$0.Timestamp>(1, _omitFieldNames ? '' : 'timestamp', subBuilder: $0.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Budget clone() => Budget()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Budget copyWith(void Function(Budget) updates) => super.copyWith((message) => updates(message as Budget)) as Budget;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Budget create() => Budget._();
  Budget createEmptyInstance() => create();
  static $pb.PbList<Budget> createRepeated() => $pb.PbList<Budget>();
  @$core.pragma('dart2js:noInline')
  static Budget getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Budget>(create);
  static Budget? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($0.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $0.Timestamp ensureTimestamp() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get balance => $_getN(1);
  @$pb.TagNumber(2)
  set balance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalance() => clearField(2);
}

class Request extends $pb.GeneratedMessage {
  factory Request({
    $core.bool? add,
    Element? element,
  }) {
    final $result = create();
    if (add != null) {
      $result.add = add;
    }
    if (element != null) {
      $result.element = element;
    }
    return $result;
  }
  Request._() : super();
  factory Request.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Request.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Request', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'add')
    ..aOM<Element>(2, _omitFieldNames ? '' : 'element', subBuilder: Element.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Request clone() => Request()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Request copyWith(void Function(Request) updates) => super.copyWith((message) => updates(message as Request)) as Request;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Request create() => Request._();
  Request createEmptyInstance() => create();
  static $pb.PbList<Request> createRepeated() => $pb.PbList<Request>();
  @$core.pragma('dart2js:noInline')
  static Request getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Request>(create);
  static Request? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get add => $_getBF(0);
  @$pb.TagNumber(1)
  set add($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAdd() => $_has(0);
  @$pb.TagNumber(1)
  void clearAdd() => clearField(1);

  @$pb.TagNumber(2)
  Element get element => $_getN(1);
  @$pb.TagNumber(2)
  set element(Element v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasElement() => $_has(1);
  @$pb.TagNumber(2)
  void clearElement() => clearField(2);
  @$pb.TagNumber(2)
  Element ensureElement() => $_ensure(1);
}

class Element extends $pb.GeneratedMessage {
  factory Element({
    $core.String? id,
    $core.List<$core.int>? value,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  Element._() : super();
  factory Element.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Element.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Element', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Element clone() => Element()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Element copyWith(void Function(Element) updates) => super.copyWith((message) => updates(message as Element)) as Element;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Element create() => Element._();
  Element createEmptyInstance() => create();
  static $pb.PbList<Element> createRepeated() => $pb.PbList<Element>();
  @$core.pragma('dart2js:noInline')
  static Element getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Element>(create);
  static Element? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class Combination extends $pb.GeneratedMessage {
  factory Combination({
    $core.Iterable<Element>? elements,
  }) {
    final $result = create();
    if (elements != null) {
      $result.elements.addAll(elements);
    }
    return $result;
  }
  Combination._() : super();
  factory Combination.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Combination.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Combination', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..pc<Element>(1, _omitFieldNames ? '' : 'elements', $pb.PbFieldType.PM, subBuilder: Element.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Combination clone() => Combination()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Combination copyWith(void Function(Combination) updates) => super.copyWith((message) => updates(message as Combination)) as Combination;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Combination create() => Combination._();
  Combination createEmptyInstance() => create();
  static $pb.PbList<Combination> createRepeated() => $pb.PbList<Combination>();
  @$core.pragma('dart2js:noInline')
  static Combination getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Combination>(create);
  static Combination? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Element> get elements => $_getList(0);
}

class Permutation extends $pb.GeneratedMessage {
  factory Permutation({
    $core.List<$core.int>? value,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  Permutation._() : super();
  factory Permutation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Permutation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Permutation', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Permutation clone() => Permutation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Permutation copyWith(void Function(Permutation) updates) => super.copyWith((message) => updates(message as Permutation)) as Permutation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Permutation create() => Permutation._();
  Permutation createEmptyInstance() => create();
  static $pb.PbList<Permutation> createRepeated() => $pb.PbList<Permutation>();
  @$core.pragma('dart2js:noInline')
  static Permutation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Permutation>(create);
  static Permutation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class Target extends $pb.GeneratedMessage {
  factory Target({
    $core.List<$core.int>? value,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  Target._() : super();
  factory Target.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Target.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Target', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Target clone() => Target()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Target copyWith(void Function(Target) updates) => super.copyWith((message) => updates(message as Target)) as Target;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Target create() => Target._();
  Target createEmptyInstance() => create();
  static $pb.PbList<Target> createRepeated() => $pb.PbList<Target>();
  @$core.pragma('dart2js:noInline')
  static Target getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Target>(create);
  static Target? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class Result extends $pb.GeneratedMessage {
  factory Result({
    $core.bool? success,
    $core.List<$core.int>? value,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  Result._() : super();
  factory Result.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Result.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Result', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Result clone() => Result()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Result copyWith(void Function(Result) updates) => super.copyWith((message) => updates(message as Result)) as Result;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Result create() => Result._();
  Result createEmptyInstance() => create();
  static $pb.PbList<Result> createRepeated() => $pb.PbList<Result>();
  @$core.pragma('dart2js:noInline')
  static Result getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Result>(create);
  static Result? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class Status extends $pb.GeneratedMessage {
  factory Status({
    $core.int? code,
    $core.String? message,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  Status._() : super();
  factory Status.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Status.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Status', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Status clone() => Status()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Status copyWith(void Function(Status) updates) => super.copyWith((message) => updates(message as Status)) as Status;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Status create() => Status._();
  Status createEmptyInstance() => create();
  static $pb.PbList<Status> createRepeated() => $pb.PbList<Status>();
  @$core.pragma('dart2js:noInline')
  static Status getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Status>(create);
  static Status? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get code => $_getIZ(0);
  @$pb.TagNumber(1)
  set code($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class WorkersResponse extends $pb.GeneratedMessage {
  factory WorkersResponse({
    $core.Iterable<Worker>? workers,
  }) {
    final $result = create();
    if (workers != null) {
      $result.workers.addAll(workers);
    }
    return $result;
  }
  WorkersResponse._() : super();
  factory WorkersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WorkersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..pc<Worker>(1, _omitFieldNames ? '' : 'workers', $pb.PbFieldType.PM, subBuilder: Worker.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkersResponse clone() => WorkersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkersResponse copyWith(void Function(WorkersResponse) updates) => super.copyWith((message) => updates(message as WorkersResponse)) as WorkersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkersResponse create() => WorkersResponse._();
  WorkersResponse createEmptyInstance() => create();
  static $pb.PbList<WorkersResponse> createRepeated() => $pb.PbList<WorkersResponse>();
  @$core.pragma('dart2js:noInline')
  static WorkersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkersResponse>(create);
  static WorkersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Worker> get workers => $_getList(0);
}

class WorkerRequest extends $pb.GeneratedMessage {
  factory WorkerRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  WorkerRequest._() : super();
  factory WorkerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WorkerRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkerRequest clone() => WorkerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkerRequest copyWith(void Function(WorkerRequest) updates) => super.copyWith((message) => updates(message as WorkerRequest)) as WorkerRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkerRequest create() => WorkerRequest._();
  WorkerRequest createEmptyInstance() => create();
  static $pb.PbList<WorkerRequest> createRepeated() => $pb.PbList<WorkerRequest>();
  @$core.pragma('dart2js:noInline')
  static WorkerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkerRequest>(create);
  static WorkerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class WorkerResponse extends $pb.GeneratedMessage {
  factory WorkerResponse({
    Worker? worker,
  }) {
    final $result = create();
    if (worker != null) {
      $result.worker = worker;
    }
    return $result;
  }
  WorkerResponse._() : super();
  factory WorkerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WorkerResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<Worker>(1, _omitFieldNames ? '' : 'worker', subBuilder: Worker.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkerResponse clone() => WorkerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkerResponse copyWith(void Function(WorkerResponse) updates) => super.copyWith((message) => updates(message as WorkerResponse)) as WorkerResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkerResponse create() => WorkerResponse._();
  WorkerResponse createEmptyInstance() => create();
  static $pb.PbList<WorkerResponse> createRepeated() => $pb.PbList<WorkerResponse>();
  @$core.pragma('dart2js:noInline')
  static WorkerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkerResponse>(create);
  static WorkerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Worker get worker => $_getN(0);
  @$pb.TagNumber(1)
  set worker(Worker v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorker() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorker() => clearField(1);
  @$pb.TagNumber(1)
  Worker ensureWorker() => $_ensure(0);
}

class ProcResponse extends $pb.GeneratedMessage {
  factory ProcResponse({
    Proc? proc,
  }) {
    final $result = create();
    if (proc != null) {
      $result.proc = proc;
    }
    return $result;
  }
  ProcResponse._() : super();
  factory ProcResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<Proc>(1, _omitFieldNames ? '' : 'proc', subBuilder: Proc.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcResponse clone() => ProcResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcResponse copyWith(void Function(ProcResponse) updates) => super.copyWith((message) => updates(message as ProcResponse)) as ProcResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcResponse create() => ProcResponse._();
  ProcResponse createEmptyInstance() => create();
  static $pb.PbList<ProcResponse> createRepeated() => $pb.PbList<ProcResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcResponse>(create);
  static ProcResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Proc get proc => $_getN(0);
  @$pb.TagNumber(1)
  set proc(Proc v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProc() => $_has(0);
  @$pb.TagNumber(1)
  void clearProc() => clearField(1);
  @$pb.TagNumber(1)
  Proc ensureProc() => $_ensure(0);
}

class CpuResponse extends $pb.GeneratedMessage {
  factory CpuResponse({
    Cpu? cpu,
  }) {
    final $result = create();
    if (cpu != null) {
      $result.cpu = cpu;
    }
    return $result;
  }
  CpuResponse._() : super();
  factory CpuResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CpuResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CpuResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<Cpu>(1, _omitFieldNames ? '' : 'cpu', subBuilder: Cpu.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CpuResponse clone() => CpuResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CpuResponse copyWith(void Function(CpuResponse) updates) => super.copyWith((message) => updates(message as CpuResponse)) as CpuResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CpuResponse create() => CpuResponse._();
  CpuResponse createEmptyInstance() => create();
  static $pb.PbList<CpuResponse> createRepeated() => $pb.PbList<CpuResponse>();
  @$core.pragma('dart2js:noInline')
  static CpuResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CpuResponse>(create);
  static CpuResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Cpu get cpu => $_getN(0);
  @$pb.TagNumber(1)
  set cpu(Cpu v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCpu() => $_has(0);
  @$pb.TagNumber(1)
  void clearCpu() => clearField(1);
  @$pb.TagNumber(1)
  Cpu ensureCpu() => $_ensure(0);
}

class MemResponse extends $pb.GeneratedMessage {
  factory MemResponse({
    Mem? mem,
  }) {
    final $result = create();
    if (mem != null) {
      $result.mem = mem;
    }
    return $result;
  }
  MemResponse._() : super();
  factory MemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MemResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<Mem>(1, _omitFieldNames ? '' : 'mem', subBuilder: Mem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MemResponse clone() => MemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MemResponse copyWith(void Function(MemResponse) updates) => super.copyWith((message) => updates(message as MemResponse)) as MemResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemResponse create() => MemResponse._();
  MemResponse createEmptyInstance() => create();
  static $pb.PbList<MemResponse> createRepeated() => $pb.PbList<MemResponse>();
  @$core.pragma('dart2js:noInline')
  static MemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemResponse>(create);
  static MemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Mem get mem => $_getN(0);
  @$pb.TagNumber(1)
  set mem(Mem v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMem() => $_has(0);
  @$pb.TagNumber(1)
  void clearMem() => clearField(1);
  @$pb.TagNumber(1)
  Mem ensureMem() => $_ensure(0);
}

class NetResponse extends $pb.GeneratedMessage {
  factory NetResponse({
    Net? net,
  }) {
    final $result = create();
    if (net != null) {
      $result.net = net;
    }
    return $result;
  }
  NetResponse._() : super();
  factory NetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NetResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<Net>(1, _omitFieldNames ? '' : 'net', subBuilder: Net.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NetResponse clone() => NetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NetResponse copyWith(void Function(NetResponse) updates) => super.copyWith((message) => updates(message as NetResponse)) as NetResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NetResponse create() => NetResponse._();
  NetResponse createEmptyInstance() => create();
  static $pb.PbList<NetResponse> createRepeated() => $pb.PbList<NetResponse>();
  @$core.pragma('dart2js:noInline')
  static NetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NetResponse>(create);
  static NetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Net get net => $_getN(0);
  @$pb.TagNumber(1)
  set net(Net v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNet() => $_has(0);
  @$pb.TagNumber(1)
  void clearNet() => clearField(1);
  @$pb.TagNumber(1)
  Net ensureNet() => $_ensure(0);
}

class UptimeResponse extends $pb.GeneratedMessage {
  factory UptimeResponse({
    Uptime? uptime,
  }) {
    final $result = create();
    if (uptime != null) {
      $result.uptime = uptime;
    }
    return $result;
  }
  UptimeResponse._() : super();
  factory UptimeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UptimeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UptimeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<Uptime>(1, _omitFieldNames ? '' : 'uptime', subBuilder: Uptime.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UptimeResponse clone() => UptimeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UptimeResponse copyWith(void Function(UptimeResponse) updates) => super.copyWith((message) => updates(message as UptimeResponse)) as UptimeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UptimeResponse create() => UptimeResponse._();
  UptimeResponse createEmptyInstance() => create();
  static $pb.PbList<UptimeResponse> createRepeated() => $pb.PbList<UptimeResponse>();
  @$core.pragma('dart2js:noInline')
  static UptimeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UptimeResponse>(create);
  static UptimeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Uptime get uptime => $_getN(0);
  @$pb.TagNumber(1)
  set uptime(Uptime v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUptime() => $_has(0);
  @$pb.TagNumber(1)
  void clearUptime() => clearField(1);
  @$pb.TagNumber(1)
  Uptime ensureUptime() => $_ensure(0);
}

class LoadAvgResponse extends $pb.GeneratedMessage {
  factory LoadAvgResponse({
    LoadAvg? loadAvg,
  }) {
    final $result = create();
    if (loadAvg != null) {
      $result.loadAvg = loadAvg;
    }
    return $result;
  }
  LoadAvgResponse._() : super();
  factory LoadAvgResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoadAvgResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoadAvgResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<LoadAvg>(1, _omitFieldNames ? '' : 'LoadAvg', protoName: 'LoadAvg', subBuilder: LoadAvg.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoadAvgResponse clone() => LoadAvgResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoadAvgResponse copyWith(void Function(LoadAvgResponse) updates) => super.copyWith((message) => updates(message as LoadAvgResponse)) as LoadAvgResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoadAvgResponse create() => LoadAvgResponse._();
  LoadAvgResponse createEmptyInstance() => create();
  static $pb.PbList<LoadAvgResponse> createRepeated() => $pb.PbList<LoadAvgResponse>();
  @$core.pragma('dart2js:noInline')
  static LoadAvgResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoadAvgResponse>(create);
  static LoadAvgResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LoadAvg get loadAvg => $_getN(0);
  @$pb.TagNumber(1)
  set loadAvg(LoadAvg v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLoadAvg() => $_has(0);
  @$pb.TagNumber(1)
  void clearLoadAvg() => clearField(1);
  @$pb.TagNumber(1)
  LoadAvg ensureLoadAvg() => $_ensure(0);
}

class PoolLoadRequest extends $pb.GeneratedMessage {
  factory PoolLoadRequest({
    $core.String? type,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    return $result;
  }
  PoolLoadRequest._() : super();
  factory PoolLoadRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PoolLoadRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PoolLoadRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PoolLoadRequest clone() => PoolLoadRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PoolLoadRequest copyWith(void Function(PoolLoadRequest) updates) => super.copyWith((message) => updates(message as PoolLoadRequest)) as PoolLoadRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PoolLoadRequest create() => PoolLoadRequest._();
  PoolLoadRequest createEmptyInstance() => create();
  static $pb.PbList<PoolLoadRequest> createRepeated() => $pb.PbList<PoolLoadRequest>();
  @$core.pragma('dart2js:noInline')
  static PoolLoadRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PoolLoadRequest>(create);
  static PoolLoadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);
}

class PoolLoadResponse extends $pb.GeneratedMessage {
  factory PoolLoadResponse({
    $core.double? load,
  }) {
    final $result = create();
    if (load != null) {
      $result.load = load;
    }
    return $result;
  }
  PoolLoadResponse._() : super();
  factory PoolLoadResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PoolLoadResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PoolLoadResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'load', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PoolLoadResponse clone() => PoolLoadResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PoolLoadResponse copyWith(void Function(PoolLoadResponse) updates) => super.copyWith((message) => updates(message as PoolLoadResponse)) as PoolLoadResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PoolLoadResponse create() => PoolLoadResponse._();
  PoolLoadResponse createEmptyInstance() => create();
  static $pb.PbList<PoolLoadResponse> createRepeated() => $pb.PbList<PoolLoadResponse>();
  @$core.pragma('dart2js:noInline')
  static PoolLoadResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PoolLoadResponse>(create);
  static PoolLoadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get load => $_getN(0);
  @$pb.TagNumber(1)
  set load($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLoad() => $_has(0);
  @$pb.TagNumber(1)
  void clearLoad() => clearField(1);
}

class Proc extends $pb.GeneratedMessage {
  factory Proc({
    Cpu? cpu,
    Mem? mem,
    Net? net,
    Uptime? uptime,
    LoadAvg? loadAvg,
  }) {
    final $result = create();
    if (cpu != null) {
      $result.cpu = cpu;
    }
    if (mem != null) {
      $result.mem = mem;
    }
    if (net != null) {
      $result.net = net;
    }
    if (uptime != null) {
      $result.uptime = uptime;
    }
    if (loadAvg != null) {
      $result.loadAvg = loadAvg;
    }
    return $result;
  }
  Proc._() : super();
  factory Proc.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Proc.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Proc', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOM<Cpu>(1, _omitFieldNames ? '' : 'cpu', subBuilder: Cpu.create)
    ..aOM<Mem>(2, _omitFieldNames ? '' : 'mem', subBuilder: Mem.create)
    ..aOM<Net>(3, _omitFieldNames ? '' : 'net', subBuilder: Net.create)
    ..aOM<Uptime>(4, _omitFieldNames ? '' : 'uptime', subBuilder: Uptime.create)
    ..aOM<LoadAvg>(5, _omitFieldNames ? '' : 'loadAvg', protoName: 'loadAvg', subBuilder: LoadAvg.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Proc clone() => Proc()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Proc copyWith(void Function(Proc) updates) => super.copyWith((message) => updates(message as Proc)) as Proc;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Proc create() => Proc._();
  Proc createEmptyInstance() => create();
  static $pb.PbList<Proc> createRepeated() => $pb.PbList<Proc>();
  @$core.pragma('dart2js:noInline')
  static Proc getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Proc>(create);
  static Proc? _defaultInstance;

  @$pb.TagNumber(1)
  Cpu get cpu => $_getN(0);
  @$pb.TagNumber(1)
  set cpu(Cpu v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCpu() => $_has(0);
  @$pb.TagNumber(1)
  void clearCpu() => clearField(1);
  @$pb.TagNumber(1)
  Cpu ensureCpu() => $_ensure(0);

  @$pb.TagNumber(2)
  Mem get mem => $_getN(1);
  @$pb.TagNumber(2)
  set mem(Mem v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMem() => $_has(1);
  @$pb.TagNumber(2)
  void clearMem() => clearField(2);
  @$pb.TagNumber(2)
  Mem ensureMem() => $_ensure(1);

  @$pb.TagNumber(3)
  Net get net => $_getN(2);
  @$pb.TagNumber(3)
  set net(Net v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasNet() => $_has(2);
  @$pb.TagNumber(3)
  void clearNet() => clearField(3);
  @$pb.TagNumber(3)
  Net ensureNet() => $_ensure(2);

  @$pb.TagNumber(4)
  Uptime get uptime => $_getN(3);
  @$pb.TagNumber(4)
  set uptime(Uptime v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUptime() => $_has(3);
  @$pb.TagNumber(4)
  void clearUptime() => clearField(4);
  @$pb.TagNumber(4)
  Uptime ensureUptime() => $_ensure(3);

  @$pb.TagNumber(5)
  LoadAvg get loadAvg => $_getN(4);
  @$pb.TagNumber(5)
  set loadAvg(LoadAvg v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLoadAvg() => $_has(4);
  @$pb.TagNumber(5)
  void clearLoadAvg() => clearField(5);
  @$pb.TagNumber(5)
  LoadAvg ensureLoadAvg() => $_ensure(4);
}

class Cpu extends $pb.GeneratedMessage {
  factory Cpu({
    $fixnum.Int64? idle,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (idle != null) {
      $result.idle = idle;
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  Cpu._() : super();
  factory Cpu.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Cpu.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Cpu', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'idle', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Cpu clone() => Cpu()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Cpu copyWith(void Function(Cpu) updates) => super.copyWith((message) => updates(message as Cpu)) as Cpu;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Cpu create() => Cpu._();
  Cpu createEmptyInstance() => create();
  static $pb.PbList<Cpu> createRepeated() => $pb.PbList<Cpu>();
  @$core.pragma('dart2js:noInline')
  static Cpu getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Cpu>(create);
  static Cpu? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get idle => $_getI64(0);
  @$pb.TagNumber(1)
  set idle($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdle() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdle() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class Mem extends $pb.GeneratedMessage {
  factory Mem({
    $fixnum.Int64? used,
    $fixnum.Int64? total,
    $fixnum.Int64? swapUsed,
    $fixnum.Int64? swapTotal,
  }) {
    final $result = create();
    if (used != null) {
      $result.used = used;
    }
    if (total != null) {
      $result.total = total;
    }
    if (swapUsed != null) {
      $result.swapUsed = swapUsed;
    }
    if (swapTotal != null) {
      $result.swapTotal = swapTotal;
    }
    return $result;
  }
  Mem._() : super();
  factory Mem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Mem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Mem', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'used', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'swapUsed', $pb.PbFieldType.OU6, protoName: 'swapUsed', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'swapTotal', $pb.PbFieldType.OU6, protoName: 'swapTotal', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Mem clone() => Mem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Mem copyWith(void Function(Mem) updates) => super.copyWith((message) => updates(message as Mem)) as Mem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mem create() => Mem._();
  Mem createEmptyInstance() => create();
  static $pb.PbList<Mem> createRepeated() => $pb.PbList<Mem>();
  @$core.pragma('dart2js:noInline')
  static Mem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mem>(create);
  static Mem? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get used => $_getI64(0);
  @$pb.TagNumber(1)
  set used($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsed() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsed() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get swapUsed => $_getI64(2);
  @$pb.TagNumber(3)
  set swapUsed($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSwapUsed() => $_has(2);
  @$pb.TagNumber(3)
  void clearSwapUsed() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get swapTotal => $_getI64(3);
  @$pb.TagNumber(4)
  set swapTotal($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSwapTotal() => $_has(3);
  @$pb.TagNumber(4)
  void clearSwapTotal() => clearField(4);
}

class Net extends $pb.GeneratedMessage {
  factory Net({
    $fixnum.Int64? rx,
    $fixnum.Int64? tx,
  }) {
    final $result = create();
    if (rx != null) {
      $result.rx = rx;
    }
    if (tx != null) {
      $result.tx = tx;
    }
    return $result;
  }
  Net._() : super();
  factory Net.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Net.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Net', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'rx', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'tx', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Net clone() => Net()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Net copyWith(void Function(Net) updates) => super.copyWith((message) => updates(message as Net)) as Net;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Net create() => Net._();
  Net createEmptyInstance() => create();
  static $pb.PbList<Net> createRepeated() => $pb.PbList<Net>();
  @$core.pragma('dart2js:noInline')
  static Net getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Net>(create);
  static Net? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get rx => $_getI64(0);
  @$pb.TagNumber(1)
  set rx($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRx() => $_has(0);
  @$pb.TagNumber(1)
  void clearRx() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get tx => $_getI64(1);
  @$pb.TagNumber(2)
  set tx($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTx() => $_has(1);
  @$pb.TagNumber(2)
  void clearTx() => clearField(2);
}

class Uptime extends $pb.GeneratedMessage {
  factory Uptime({
    $fixnum.Int64? duration,
  }) {
    final $result = create();
    if (duration != null) {
      $result.duration = duration;
    }
    return $result;
  }
  Uptime._() : super();
  factory Uptime.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Uptime.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Uptime', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'duration')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Uptime clone() => Uptime()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Uptime copyWith(void Function(Uptime) updates) => super.copyWith((message) => updates(message as Uptime)) as Uptime;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Uptime create() => Uptime._();
  Uptime createEmptyInstance() => create();
  static $pb.PbList<Uptime> createRepeated() => $pb.PbList<Uptime>();
  @$core.pragma('dart2js:noInline')
  static Uptime getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Uptime>(create);
  static Uptime? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get duration => $_getI64(0);
  @$pb.TagNumber(1)
  set duration($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDuration() => $_has(0);
  @$pb.TagNumber(1)
  void clearDuration() => clearField(1);
}

class LoadAvg extends $pb.GeneratedMessage {
  factory LoadAvg({
    $core.double? oneMinute,
    $core.double? fiveMinutes,
    $core.double? fifteenMinutes,
  }) {
    final $result = create();
    if (oneMinute != null) {
      $result.oneMinute = oneMinute;
    }
    if (fiveMinutes != null) {
      $result.fiveMinutes = fiveMinutes;
    }
    if (fifteenMinutes != null) {
      $result.fifteenMinutes = fifteenMinutes;
    }
    return $result;
  }
  LoadAvg._() : super();
  factory LoadAvg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoadAvg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoadAvg', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'oneMinute', $pb.PbFieldType.OD, protoName: 'oneMinute')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'fiveMinutes', $pb.PbFieldType.OD, protoName: 'fiveMinutes')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'fifteenMinutes', $pb.PbFieldType.OD, protoName: 'fifteenMinutes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoadAvg clone() => LoadAvg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoadAvg copyWith(void Function(LoadAvg) updates) => super.copyWith((message) => updates(message as LoadAvg)) as LoadAvg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoadAvg create() => LoadAvg._();
  LoadAvg createEmptyInstance() => create();
  static $pb.PbList<LoadAvg> createRepeated() => $pb.PbList<LoadAvg>();
  @$core.pragma('dart2js:noInline')
  static LoadAvg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoadAvg>(create);
  static LoadAvg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get oneMinute => $_getN(0);
  @$pb.TagNumber(1)
  set oneMinute($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOneMinute() => $_has(0);
  @$pb.TagNumber(1)
  void clearOneMinute() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get fiveMinutes => $_getN(1);
  @$pb.TagNumber(2)
  set fiveMinutes($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFiveMinutes() => $_has(1);
  @$pb.TagNumber(2)
  void clearFiveMinutes() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get fifteenMinutes => $_getN(2);
  @$pb.TagNumber(3)
  set fifteenMinutes($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFifteenMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearFifteenMinutes() => clearField(3);
}

class Worker extends $pb.GeneratedMessage {
  factory Worker({
    $core.String? id,
    $0.Timestamp? time,
    $core.String? ip,
    $core.String? type,
    Proc? proc,
    $fixnum.Int64? ops,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (time != null) {
      $result.time = time;
    }
    if (ip != null) {
      $result.ip = ip;
    }
    if (type != null) {
      $result.type = type;
    }
    if (proc != null) {
      $result.proc = proc;
    }
    if (ops != null) {
      $result.ops = ops;
    }
    return $result;
  }
  Worker._() : super();
  factory Worker.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Worker.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Worker', package: const $pb.PackageName(_omitMessageNames ? '' : 'brutus'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOM<$0.Timestamp>(2, _omitFieldNames ? '' : 'time', subBuilder: $0.Timestamp.create)
    ..aOS(3, _omitFieldNames ? '' : 'ip')
    ..aOS(4, _omitFieldNames ? '' : 'type')
    ..aOM<Proc>(5, _omitFieldNames ? '' : 'proc', subBuilder: Proc.create)
    ..aInt64(6, _omitFieldNames ? '' : 'ops')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Worker clone() => Worker()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Worker copyWith(void Function(Worker) updates) => super.copyWith((message) => updates(message as Worker)) as Worker;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Worker create() => Worker._();
  Worker createEmptyInstance() => create();
  static $pb.PbList<Worker> createRepeated() => $pb.PbList<Worker>();
  @$core.pragma('dart2js:noInline')
  static Worker getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Worker>(create);
  static Worker? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $0.Timestamp get time => $_getN(1);
  @$pb.TagNumber(2)
  set time($0.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => clearField(2);
  @$pb.TagNumber(2)
  $0.Timestamp ensureTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get ip => $_getSZ(2);
  @$pb.TagNumber(3)
  set ip($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIp() => $_has(2);
  @$pb.TagNumber(3)
  void clearIp() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get type => $_getSZ(3);
  @$pb.TagNumber(4)
  set type($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => clearField(4);

  @$pb.TagNumber(5)
  Proc get proc => $_getN(4);
  @$pb.TagNumber(5)
  set proc(Proc v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProc() => $_has(4);
  @$pb.TagNumber(5)
  void clearProc() => clearField(5);
  @$pb.TagNumber(5)
  Proc ensureProc() => $_ensure(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get ops => $_getI64(5);
  @$pb.TagNumber(6)
  set ops($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOps() => $_has(5);
  @$pb.TagNumber(6)
  void clearOps() => clearField(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
