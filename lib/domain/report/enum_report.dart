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

enum ReportDirection {
  frontside,
  backside,
  frontflip,
  backflip,
  frontCork,
  backCork,
  frontUnder,
  backUnder,
  frontRodeo,
  backRodeo,
}

extension ReportDirectionExt on ReportDirection {
  String get name {
    switch (this) {
      case ReportDirection.frontside:
        return 'フロントサイド';
      case ReportDirection.backside:
        return 'バックサイド';
      case ReportDirection.frontflip:
        return 'フロントフリップ';
      case ReportDirection.backflip:
        return 'バックフリップ';
      case ReportDirection.frontCork:
        return 'フロントコーク';
      case ReportDirection.backCork:
        return 'バックコーク';
      case ReportDirection.frontUnder:
        return 'フロントアンダー';
      case ReportDirection.backUnder:
        return 'バックアンダー';
      case ReportDirection.frontRodeo:
        return 'フロントロデオ';
      case ReportDirection.backRodeo:
        return 'バックロデオ';
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
