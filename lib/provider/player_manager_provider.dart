import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/model/player_manager.dart';

final playerManagerProvider =
    StateNotifierProvider<PlayerManagerModel, PlayerManagerState>(
  (ref) => PlayerManagerModel(),
);
