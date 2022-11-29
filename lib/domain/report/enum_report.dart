enum ReportStance {
  mainStance,
  switchStance,
}

extension ReportStanceExt on ReportStance {
  String get name {
    switch (this) {
      case ReportStance.mainStance:
        return 'メイン';
      case ReportStance.switchStance:
        return 'スイッチ';
    }
  }
}

enum ReportSpin {
  s0,
  s180,
  s360,
  s540,
  s720,
  s900,
  s1080,
  s1260,
  s1440,
  s1620,
}

extension ReportSpinExt on ReportSpin {
  String get name {
    switch (this) {
      case ReportSpin.s0:
        return 'ストレート';
      case ReportSpin.s180:
        return '180°';
      case ReportSpin.s360:
        return '360°';
      case ReportSpin.s540:
        return '540°';
      case ReportSpin.s720:
        return '720°';
      case ReportSpin.s900:
        return '900°';
      case ReportSpin.s1080:
        return '1080°';
      case ReportSpin.s1260:
        return '1260°';
      case ReportSpin.s1440:
        return '1440°';
      case ReportSpin.s1620:
        return '1620°';
    }
  }
}
