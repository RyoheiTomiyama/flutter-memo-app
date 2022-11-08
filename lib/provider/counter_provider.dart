import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo_app/model/counter.dart';

final counterProvider =
    StateNotifierProvider<CounterModel, Counter>((ref) => CounterModel());
