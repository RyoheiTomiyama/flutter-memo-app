// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'entity_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReportTrick {
  int? get id => throw _privateConstructorUsedError;
  ReportStance? get stance => throw _privateConstructorUsedError;
  ReportDirection? get direction => throw _privateConstructorUsedError;
  ReportSpin? get spin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReportTrickCopyWith<ReportTrick> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportTrickCopyWith<$Res> {
  factory $ReportTrickCopyWith(
          ReportTrick value, $Res Function(ReportTrick) then) =
      _$ReportTrickCopyWithImpl<$Res, ReportTrick>;
  @useResult
  $Res call(
      {int? id,
      ReportStance? stance,
      ReportDirection? direction,
      ReportSpin? spin});
}

/// @nodoc
class _$ReportTrickCopyWithImpl<$Res, $Val extends ReportTrick>
    implements $ReportTrickCopyWith<$Res> {
  _$ReportTrickCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? stance = freezed,
    Object? direction = freezed,
    Object? spin = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      stance: freezed == stance
          ? _value.stance
          : stance // ignore: cast_nullable_to_non_nullable
              as ReportStance?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ReportDirection?,
      spin: freezed == spin
          ? _value.spin
          : spin // ignore: cast_nullable_to_non_nullable
              as ReportSpin?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$ReportTrickCopyWith<$Res>
    implements $ReportTrickCopyWith<$Res> {
  factory _$$$ReportTrickCopyWith(
          _$$ReportTrick value, $Res Function(_$$ReportTrick) then) =
      __$$$ReportTrickCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      ReportStance? stance,
      ReportDirection? direction,
      ReportSpin? spin});
}

/// @nodoc
class __$$$ReportTrickCopyWithImpl<$Res>
    extends _$ReportTrickCopyWithImpl<$Res, _$$ReportTrick>
    implements _$$$ReportTrickCopyWith<$Res> {
  __$$$ReportTrickCopyWithImpl(
      _$$ReportTrick _value, $Res Function(_$$ReportTrick) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? stance = freezed,
    Object? direction = freezed,
    Object? spin = freezed,
  }) {
    return _then(_$$ReportTrick(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      stance: freezed == stance
          ? _value.stance
          : stance // ignore: cast_nullable_to_non_nullable
              as ReportStance?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as ReportDirection?,
      spin: freezed == spin
          ? _value.spin
          : spin // ignore: cast_nullable_to_non_nullable
              as ReportSpin?,
    ));
  }
}

/// @nodoc

class _$$ReportTrick implements $ReportTrick {
  const _$$ReportTrick(
      {this.id = null,
      this.stance = null,
      this.direction = null,
      this.spin = null});

  @override
  @JsonKey()
  final int? id;
  @override
  @JsonKey()
  final ReportStance? stance;
  @override
  @JsonKey()
  final ReportDirection? direction;
  @override
  @JsonKey()
  final ReportSpin? spin;

  @override
  String toString() {
    return 'ReportTrick(id: $id, stance: $stance, direction: $direction, spin: $spin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$ReportTrick &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stance, stance) || other.stance == stance) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.spin, spin) || other.spin == spin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, stance, direction, spin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$ReportTrickCopyWith<_$$ReportTrick> get copyWith =>
      __$$$ReportTrickCopyWithImpl<_$$ReportTrick>(this, _$identity);
}

abstract class $ReportTrick implements ReportTrick {
  const factory $ReportTrick(
      {final int? id,
      final ReportStance? stance,
      final ReportDirection? direction,
      final ReportSpin? spin}) = _$$ReportTrick;

  @override
  int? get id;
  @override
  ReportStance? get stance;
  @override
  ReportDirection? get direction;
  @override
  ReportSpin? get spin;
  @override
  @JsonKey(ignore: true)
  _$$$ReportTrickCopyWith<_$$ReportTrick> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReportResult {
  int? get id => throw _privateConstructorUsedError;
  int? get approachScore => throw _privateConstructorUsedError;
  int? get takeoffScore => throw _privateConstructorUsedError;
  int? get peakScore => throw _privateConstructorUsedError;
  int? get landingScore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReportResultCopyWith<ReportResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportResultCopyWith<$Res> {
  factory $ReportResultCopyWith(
          ReportResult value, $Res Function(ReportResult) then) =
      _$ReportResultCopyWithImpl<$Res, ReportResult>;
  @useResult
  $Res call(
      {int? id,
      int? approachScore,
      int? takeoffScore,
      int? peakScore,
      int? landingScore});
}

/// @nodoc
class _$ReportResultCopyWithImpl<$Res, $Val extends ReportResult>
    implements $ReportResultCopyWith<$Res> {
  _$ReportResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? approachScore = freezed,
    Object? takeoffScore = freezed,
    Object? peakScore = freezed,
    Object? landingScore = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      approachScore: freezed == approachScore
          ? _value.approachScore
          : approachScore // ignore: cast_nullable_to_non_nullable
              as int?,
      takeoffScore: freezed == takeoffScore
          ? _value.takeoffScore
          : takeoffScore // ignore: cast_nullable_to_non_nullable
              as int?,
      peakScore: freezed == peakScore
          ? _value.peakScore
          : peakScore // ignore: cast_nullable_to_non_nullable
              as int?,
      landingScore: freezed == landingScore
          ? _value.landingScore
          : landingScore // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$$ReportResultCopyWith<$Res>
    implements $ReportResultCopyWith<$Res> {
  factory _$$$ReportResultCopyWith(
          _$$ReportResult value, $Res Function(_$$ReportResult) then) =
      __$$$ReportResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? approachScore,
      int? takeoffScore,
      int? peakScore,
      int? landingScore});
}

/// @nodoc
class __$$$ReportResultCopyWithImpl<$Res>
    extends _$ReportResultCopyWithImpl<$Res, _$$ReportResult>
    implements _$$$ReportResultCopyWith<$Res> {
  __$$$ReportResultCopyWithImpl(
      _$$ReportResult _value, $Res Function(_$$ReportResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? approachScore = freezed,
    Object? takeoffScore = freezed,
    Object? peakScore = freezed,
    Object? landingScore = freezed,
  }) {
    return _then(_$$ReportResult(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      approachScore: freezed == approachScore
          ? _value.approachScore
          : approachScore // ignore: cast_nullable_to_non_nullable
              as int?,
      takeoffScore: freezed == takeoffScore
          ? _value.takeoffScore
          : takeoffScore // ignore: cast_nullable_to_non_nullable
              as int?,
      peakScore: freezed == peakScore
          ? _value.peakScore
          : peakScore // ignore: cast_nullable_to_non_nullable
              as int?,
      landingScore: freezed == landingScore
          ? _value.landingScore
          : landingScore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$$ReportResult implements $ReportResult {
  const _$$ReportResult(
      {this.id = null,
      this.approachScore = null,
      this.takeoffScore = null,
      this.peakScore = null,
      this.landingScore = null});

  @override
  @JsonKey()
  final int? id;
  @override
  @JsonKey()
  final int? approachScore;
  @override
  @JsonKey()
  final int? takeoffScore;
  @override
  @JsonKey()
  final int? peakScore;
  @override
  @JsonKey()
  final int? landingScore;

  @override
  String toString() {
    return 'ReportResult(id: $id, approachScore: $approachScore, takeoffScore: $takeoffScore, peakScore: $peakScore, landingScore: $landingScore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$$ReportResult &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.approachScore, approachScore) ||
                other.approachScore == approachScore) &&
            (identical(other.takeoffScore, takeoffScore) ||
                other.takeoffScore == takeoffScore) &&
            (identical(other.peakScore, peakScore) ||
                other.peakScore == peakScore) &&
            (identical(other.landingScore, landingScore) ||
                other.landingScore == landingScore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, approachScore, takeoffScore, peakScore, landingScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$$ReportResultCopyWith<_$$ReportResult> get copyWith =>
      __$$$ReportResultCopyWithImpl<_$$ReportResult>(this, _$identity);
}

abstract class $ReportResult implements ReportResult {
  const factory $ReportResult(
      {final int? id,
      final int? approachScore,
      final int? takeoffScore,
      final int? peakScore,
      final int? landingScore}) = _$$ReportResult;

  @override
  int? get id;
  @override
  int? get approachScore;
  @override
  int? get takeoffScore;
  @override
  int? get peakScore;
  @override
  int? get landingScore;
  @override
  @JsonKey(ignore: true)
  _$$$ReportResultCopyWith<_$$ReportResult> get copyWith =>
      throw _privateConstructorUsedError;
}
