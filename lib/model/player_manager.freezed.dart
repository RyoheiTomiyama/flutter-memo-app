// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'player_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlayerManagerState {
  VideoPlayerController? get controller => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerManagerStateCopyWith<PlayerManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerManagerStateCopyWith<$Res> {
  factory $PlayerManagerStateCopyWith(
          PlayerManagerState value, $Res Function(PlayerManagerState) then) =
      _$PlayerManagerStateCopyWithImpl<$Res, PlayerManagerState>;
  @useResult
  $Res call({VideoPlayerController? controller});
}

/// @nodoc
class _$PlayerManagerStateCopyWithImpl<$Res, $Val extends PlayerManagerState>
    implements $PlayerManagerStateCopyWith<$Res> {
  _$PlayerManagerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
  }) {
    return _then(_value.copyWith(
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerManagerStateCopyWith<$Res>
    implements $PlayerManagerStateCopyWith<$Res> {
  factory _$$_PlayerManagerStateCopyWith(_$_PlayerManagerState value,
          $Res Function(_$_PlayerManagerState) then) =
      __$$_PlayerManagerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VideoPlayerController? controller});
}

/// @nodoc
class __$$_PlayerManagerStateCopyWithImpl<$Res>
    extends _$PlayerManagerStateCopyWithImpl<$Res, _$_PlayerManagerState>
    implements _$$_PlayerManagerStateCopyWith<$Res> {
  __$$_PlayerManagerStateCopyWithImpl(
      _$_PlayerManagerState _value, $Res Function(_$_PlayerManagerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
  }) {
    return _then(_$_PlayerManagerState(
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
    ));
  }
}

/// @nodoc

class _$_PlayerManagerState extends _PlayerManagerState
    with DiagnosticableTreeMixin {
  const _$_PlayerManagerState({this.controller = null}) : super._();

  @override
  @JsonKey()
  final VideoPlayerController? controller;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PlayerManagerState(controller: $controller)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PlayerManagerState'))
      ..add(DiagnosticsProperty('controller', controller));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerManagerState &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, controller);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerManagerStateCopyWith<_$_PlayerManagerState> get copyWith =>
      __$$_PlayerManagerStateCopyWithImpl<_$_PlayerManagerState>(
          this, _$identity);
}

abstract class _PlayerManagerState extends PlayerManagerState {
  const factory _PlayerManagerState({final VideoPlayerController? controller}) =
      _$_PlayerManagerState;
  const _PlayerManagerState._() : super._();

  @override
  VideoPlayerController? get controller;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerManagerStateCopyWith<_$_PlayerManagerState> get copyWith =>
      throw _privateConstructorUsedError;
}
