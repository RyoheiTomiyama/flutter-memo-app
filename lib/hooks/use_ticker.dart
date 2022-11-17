import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Ticker useTicker(Ticker ticker) {
  return use(TickerHook(ticker));
  // final t = useState(ticker);
  // useEffect(() {
  //   if (t.value.isTicking) {
  //     t.value.stop();
  //     t.value.dispose();
  //   }
  // });
  // return t;
}

class TickerHook extends Hook<Ticker> {
  final Ticker ticker;

  const TickerHook(this.ticker);

  @override
  TickerHookState createState() => TickerHookState();
}

class TickerHookState extends HookState<Ticker, TickerHook> {
  late Ticker _ticker;

  @override
  void initHook() {
    super.initHook();
    _ticker = hook.ticker;
  }

  @override
  Ticker build(BuildContext context) => _ticker;

  @override
  void dispose() {
    super.dispose();
    if (_ticker.isTicking) {
      _ticker.stop();
      _ticker.dispose();
    }
  }
}
