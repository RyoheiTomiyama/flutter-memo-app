import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'counter.freezed.dart';

@freezed
class Counter with _$Counter {
  const factory Counter({
    required int count,
  }) = _Counter;
}

class CounterModel extends StateNotifier<Counter> {
  CounterModel() : super(const Counter(count: 0));

  incrementCounter() {
    state = state.copyWith(count: state.count + 1);
  }
}
