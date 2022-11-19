// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_gallery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VideoGalleryState {
  List<Gallery> get galleryList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VideoGalleryStateCopyWith<VideoGalleryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoGalleryStateCopyWith<$Res> {
  factory $VideoGalleryStateCopyWith(
          VideoGalleryState value, $Res Function(VideoGalleryState) then) =
      _$VideoGalleryStateCopyWithImpl<$Res, VideoGalleryState>;
  @useResult
  $Res call({List<Gallery> galleryList});
}

/// @nodoc
class _$VideoGalleryStateCopyWithImpl<$Res, $Val extends VideoGalleryState>
    implements $VideoGalleryStateCopyWith<$Res> {
  _$VideoGalleryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? galleryList = null,
  }) {
    return _then(_value.copyWith(
      galleryList: null == galleryList
          ? _value.galleryList
          : galleryList // ignore: cast_nullable_to_non_nullable
              as List<Gallery>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VideoGalleryStateCopyWith<$Res>
    implements $VideoGalleryStateCopyWith<$Res> {
  factory _$$_VideoGalleryStateCopyWith(_$_VideoGalleryState value,
          $Res Function(_$_VideoGalleryState) then) =
      __$$_VideoGalleryStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Gallery> galleryList});
}

/// @nodoc
class __$$_VideoGalleryStateCopyWithImpl<$Res>
    extends _$VideoGalleryStateCopyWithImpl<$Res, _$_VideoGalleryState>
    implements _$$_VideoGalleryStateCopyWith<$Res> {
  __$$_VideoGalleryStateCopyWithImpl(
      _$_VideoGalleryState _value, $Res Function(_$_VideoGalleryState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? galleryList = null,
  }) {
    return _then(_$_VideoGalleryState(
      galleryList: null == galleryList
          ? _value._galleryList
          : galleryList // ignore: cast_nullable_to_non_nullable
              as List<Gallery>,
    ));
  }
}

/// @nodoc

class _$_VideoGalleryState extends _VideoGalleryState
    with DiagnosticableTreeMixin {
  const _$_VideoGalleryState({final List<Gallery> galleryList = const []})
      : _galleryList = galleryList,
        super._();

  final List<Gallery> _galleryList;
  @override
  @JsonKey()
  List<Gallery> get galleryList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryList);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoGalleryState(galleryList: $galleryList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoGalleryState'))
      ..add(DiagnosticsProperty('galleryList', galleryList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoGalleryState &&
            const DeepCollectionEquality()
                .equals(other._galleryList, _galleryList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_galleryList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoGalleryStateCopyWith<_$_VideoGalleryState> get copyWith =>
      __$$_VideoGalleryStateCopyWithImpl<_$_VideoGalleryState>(
          this, _$identity);
}

abstract class _VideoGalleryState extends VideoGalleryState {
  const factory _VideoGalleryState({final List<Gallery> galleryList}) =
      _$_VideoGalleryState;
  const _VideoGalleryState._() : super._();

  @override
  List<Gallery> get galleryList;
  @override
  @JsonKey(ignore: true)
  _$$_VideoGalleryStateCopyWith<_$_VideoGalleryState> get copyWith =>
      throw _privateConstructorUsedError;
}
