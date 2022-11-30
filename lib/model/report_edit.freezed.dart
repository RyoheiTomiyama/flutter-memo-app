// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'report_edit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReportEditState {
  ReportTrick get trick => throw _privateConstructorUsedError;
  ReportResult get result => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReportEditStateCopyWith<ReportEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportEditStateCopyWith<$Res> {
  factory $ReportEditStateCopyWith(
          ReportEditState value, $Res Function(ReportEditState) then) =
      _$ReportEditStateCopyWithImpl<$Res, ReportEditState>;
  @useResult
  $Res call({ReportTrick trick, ReportResult result});

  $ReportTrickCopyWith<$Res> get trick;
  $ReportResultCopyWith<$Res> get result;
}

/// @nodoc
class _$ReportEditStateCopyWithImpl<$Res, $Val extends ReportEditState>
    implements $ReportEditStateCopyWith<$Res> {
  _$ReportEditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trick = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      trick: null == trick
          ? _value.trick
          : trick // ignore: cast_nullable_to_non_nullable
              as ReportTrick,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as ReportResult,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReportTrickCopyWith<$Res> get trick {
    return $ReportTrickCopyWith<$Res>(_value.trick, (value) {
      return _then(_value.copyWith(trick: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReportResultCopyWith<$Res> get result {
    return $ReportResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ReportEditStateCopyWith<$Res>
    implements $ReportEditStateCopyWith<$Res> {
  factory _$$_ReportEditStateCopyWith(
          _$_ReportEditState value, $Res Function(_$_ReportEditState) then) =
      __$$_ReportEditStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ReportTrick trick, ReportResult result});

  @override
  $ReportTrickCopyWith<$Res> get trick;
  @override
  $ReportResultCopyWith<$Res> get result;
}

/// @nodoc
class __$$_ReportEditStateCopyWithImpl<$Res>
    extends _$ReportEditStateCopyWithImpl<$Res, _$_ReportEditState>
    implements _$$_ReportEditStateCopyWith<$Res> {
  __$$_ReportEditStateCopyWithImpl(
      _$_ReportEditState _value, $Res Function(_$_ReportEditState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trick = null,
    Object? result = null,
  }) {
    return _then(_$_ReportEditState(
      trick: null == trick
          ? _value.trick
          : trick // ignore: cast_nullable_to_non_nullable
              as ReportTrick,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as ReportResult,
    ));
  }
}

/// @nodoc

class _$_ReportEditState extends _ReportEditState with DiagnosticableTreeMixin {
  _$_ReportEditState(
      {this.trick = const ReportTrick(), this.result = const ReportResult()})
      : super._();

  @override
  @JsonKey()
  final ReportTrick trick;
  @override
  @JsonKey()
  final ReportResult result;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReportEditState(trick: $trick, result: $result)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReportEditState'))
      ..add(DiagnosticsProperty('trick', trick))
      ..add(DiagnosticsProperty('result', result));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReportEditState &&
            (identical(other.trick, trick) || other.trick == trick) &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trick, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReportEditStateCopyWith<_$_ReportEditState> get copyWith =>
      __$$_ReportEditStateCopyWithImpl<_$_ReportEditState>(this, _$identity);
}

abstract class _ReportEditState extends ReportEditState {
  factory _ReportEditState(
      {final ReportTrick trick,
      final ReportResult result}) = _$_ReportEditState;
  _ReportEditState._() : super._();

  @override
  ReportTrick get trick;
  @override
  ReportResult get result;
  @override
  @JsonKey(ignore: true)
  _$$_ReportEditStateCopyWith<_$_ReportEditState> get copyWith =>
      throw _privateConstructorUsedError;
}
