// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String title;
  final String content;
  final int? category;
  const Todo(
      {required this.id,
      required this.title,
      required this.content,
      this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(content);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int>(category);
    }
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      category: serializer.fromJson<int?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'category': serializer.toJson<int?>(category),
    };
  }

  Todo copyWith(
          {int? id,
          String? title,
          String? content,
          Value<int?> category = const Value.absent()}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        category: category.present ? category.value : this.category,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.category == this.category);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<int?> category;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    this.category = const Value.absent(),
  })  : title = Value(title),
        content = Value(content);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<int>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'body': content,
      if (category != null) 'category': category,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<int?>? category}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['body'] = Variable<String>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, title, content, category];
  @override
  String get aliasedName => _alias ?? 'todos';
  @override
  String get actualTableName => 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['body']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todo(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      category: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category']),
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

class Report extends DataClass implements Insertable<Report> {
  final int id;
  final String videoId;
  const Report({required this.id, required this.videoId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['video_id'] = Variable<String>(videoId);
    return map;
  }

  ReportsCompanion toCompanion(bool nullToAbsent) {
    return ReportsCompanion(
      id: Value(id),
      videoId: Value(videoId),
    );
  }

  factory Report.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Report(
      id: serializer.fromJson<int>(json['id']),
      videoId: serializer.fromJson<String>(json['videoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'videoId': serializer.toJson<String>(videoId),
    };
  }

  Report copyWith({int? id, String? videoId}) => Report(
        id: id ?? this.id,
        videoId: videoId ?? this.videoId,
      );
  @override
  String toString() {
    return (StringBuffer('Report(')
          ..write('id: $id, ')
          ..write('videoId: $videoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, videoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Report && other.id == this.id && other.videoId == this.videoId);
}

class ReportsCompanion extends UpdateCompanion<Report> {
  final Value<int> id;
  final Value<String> videoId;
  const ReportsCompanion({
    this.id = const Value.absent(),
    this.videoId = const Value.absent(),
  });
  ReportsCompanion.insert({
    this.id = const Value.absent(),
    required String videoId,
  }) : videoId = Value(videoId);
  static Insertable<Report> custom({
    Expression<int>? id,
    Expression<String>? videoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (videoId != null) 'video_id': videoId,
    });
  }

  ReportsCompanion copyWith({Value<int>? id, Value<String>? videoId}) {
    return ReportsCompanion(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportsCompanion(')
          ..write('id: $id, ')
          ..write('videoId: $videoId')
          ..write(')'))
        .toString();
  }
}

class $ReportsTable extends Reports with TableInfo<$ReportsTable, Report> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _videoIdMeta = const VerificationMeta('videoId');
  @override
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
      'video_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, videoId];
  @override
  String get aliasedName => _alias ?? 'reports';
  @override
  String get actualTableName => 'reports';
  @override
  VerificationContext validateIntegrity(Insertable<Report> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Report map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Report(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      videoId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}video_id'])!,
    );
  }

  @override
  $ReportsTable createAlias(String alias) {
    return $ReportsTable(attachedDatabase, alias);
  }
}

class ReportTrick extends DataClass implements Insertable<ReportTrick> {
  final int id;
  final ReportStance? stance;
  final ReportDirection? direction;
  final ReportSpin? spin;
  final int? reportId;
  const ReportTrick(
      {required this.id,
      this.stance,
      this.direction,
      this.spin,
      this.reportId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || stance != null) {
      final converter = $ReportTricksTable.$converter0n;
      map['stance'] = Variable<int>(converter.toSql(stance));
    }
    if (!nullToAbsent || direction != null) {
      final converter = $ReportTricksTable.$converter1n;
      map['direction'] = Variable<int>(converter.toSql(direction));
    }
    if (!nullToAbsent || spin != null) {
      final converter = $ReportTricksTable.$converter2n;
      map['spin'] = Variable<int>(converter.toSql(spin));
    }
    if (!nullToAbsent || reportId != null) {
      map['report_id'] = Variable<int>(reportId);
    }
    return map;
  }

  ReportTricksCompanion toCompanion(bool nullToAbsent) {
    return ReportTricksCompanion(
      id: Value(id),
      stance:
          stance == null && nullToAbsent ? const Value.absent() : Value(stance),
      direction: direction == null && nullToAbsent
          ? const Value.absent()
          : Value(direction),
      spin: spin == null && nullToAbsent ? const Value.absent() : Value(spin),
      reportId: reportId == null && nullToAbsent
          ? const Value.absent()
          : Value(reportId),
    );
  }

  factory ReportTrick.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReportTrick(
      id: serializer.fromJson<int>(json['id']),
      stance: serializer.fromJson<ReportStance?>(json['stance']),
      direction: serializer.fromJson<ReportDirection?>(json['direction']),
      spin: serializer.fromJson<ReportSpin?>(json['spin']),
      reportId: serializer.fromJson<int?>(json['reportId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stance': serializer.toJson<ReportStance?>(stance),
      'direction': serializer.toJson<ReportDirection?>(direction),
      'spin': serializer.toJson<ReportSpin?>(spin),
      'reportId': serializer.toJson<int?>(reportId),
    };
  }

  ReportTrick copyWith(
          {int? id,
          Value<ReportStance?> stance = const Value.absent(),
          Value<ReportDirection?> direction = const Value.absent(),
          Value<ReportSpin?> spin = const Value.absent(),
          Value<int?> reportId = const Value.absent()}) =>
      ReportTrick(
        id: id ?? this.id,
        stance: stance.present ? stance.value : this.stance,
        direction: direction.present ? direction.value : this.direction,
        spin: spin.present ? spin.value : this.spin,
        reportId: reportId.present ? reportId.value : this.reportId,
      );
  @override
  String toString() {
    return (StringBuffer('ReportTrick(')
          ..write('id: $id, ')
          ..write('stance: $stance, ')
          ..write('direction: $direction, ')
          ..write('spin: $spin, ')
          ..write('reportId: $reportId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stance, direction, spin, reportId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReportTrick &&
          other.id == this.id &&
          other.stance == this.stance &&
          other.direction == this.direction &&
          other.spin == this.spin &&
          other.reportId == this.reportId);
}

class ReportTricksCompanion extends UpdateCompanion<ReportTrick> {
  final Value<int> id;
  final Value<ReportStance?> stance;
  final Value<ReportDirection?> direction;
  final Value<ReportSpin?> spin;
  final Value<int?> reportId;
  const ReportTricksCompanion({
    this.id = const Value.absent(),
    this.stance = const Value.absent(),
    this.direction = const Value.absent(),
    this.spin = const Value.absent(),
    this.reportId = const Value.absent(),
  });
  ReportTricksCompanion.insert({
    this.id = const Value.absent(),
    this.stance = const Value.absent(),
    this.direction = const Value.absent(),
    this.spin = const Value.absent(),
    this.reportId = const Value.absent(),
  });
  static Insertable<ReportTrick> custom({
    Expression<int>? id,
    Expression<int>? stance,
    Expression<int>? direction,
    Expression<int>? spin,
    Expression<int>? reportId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stance != null) 'stance': stance,
      if (direction != null) 'direction': direction,
      if (spin != null) 'spin': spin,
      if (reportId != null) 'report_id': reportId,
    });
  }

  ReportTricksCompanion copyWith(
      {Value<int>? id,
      Value<ReportStance?>? stance,
      Value<ReportDirection?>? direction,
      Value<ReportSpin?>? spin,
      Value<int?>? reportId}) {
    return ReportTricksCompanion(
      id: id ?? this.id,
      stance: stance ?? this.stance,
      direction: direction ?? this.direction,
      spin: spin ?? this.spin,
      reportId: reportId ?? this.reportId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stance.present) {
      final converter = $ReportTricksTable.$converter0n;
      map['stance'] = Variable<int>(converter.toSql(stance.value));
    }
    if (direction.present) {
      final converter = $ReportTricksTable.$converter1n;
      map['direction'] = Variable<int>(converter.toSql(direction.value));
    }
    if (spin.present) {
      final converter = $ReportTricksTable.$converter2n;
      map['spin'] = Variable<int>(converter.toSql(spin.value));
    }
    if (reportId.present) {
      map['report_id'] = Variable<int>(reportId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportTricksCompanion(')
          ..write('id: $id, ')
          ..write('stance: $stance, ')
          ..write('direction: $direction, ')
          ..write('spin: $spin, ')
          ..write('reportId: $reportId')
          ..write(')'))
        .toString();
  }
}

class $ReportTricksTable extends ReportTricks
    with TableInfo<$ReportTricksTable, ReportTrick> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportTricksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _stanceMeta = const VerificationMeta('stance');
  @override
  late final GeneratedColumnWithTypeConverter<ReportStance?, int> stance =
      GeneratedColumn<int>('stance', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<ReportStance?>($ReportTricksTable.$converter0n);
  final VerificationMeta _directionMeta = const VerificationMeta('direction');
  @override
  late final GeneratedColumnWithTypeConverter<ReportDirection?, int> direction =
      GeneratedColumn<int>('direction', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<ReportDirection?>($ReportTricksTable.$converter1n);
  final VerificationMeta _spinMeta = const VerificationMeta('spin');
  @override
  late final GeneratedColumnWithTypeConverter<ReportSpin?, int> spin =
      GeneratedColumn<int>('spin', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<ReportSpin?>($ReportTricksTable.$converter2n);
  final VerificationMeta _reportIdMeta = const VerificationMeta('reportId');
  @override
  late final GeneratedColumn<int> reportId = GeneratedColumn<int>(
      'report_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, stance, direction, spin, reportId];
  @override
  String get aliasedName => _alias ?? 'report_tricks';
  @override
  String get actualTableName => 'report_tricks';
  @override
  VerificationContext validateIntegrity(Insertable<ReportTrick> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_stanceMeta, const VerificationResult.success());
    context.handle(_directionMeta, const VerificationResult.success());
    context.handle(_spinMeta, const VerificationResult.success());
    if (data.containsKey('report_id')) {
      context.handle(_reportIdMeta,
          reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportTrick map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportTrick(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      stance: $ReportTricksTable.$converter0n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}stance'])),
      direction: $ReportTricksTable.$converter1n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}direction'])),
      spin: $ReportTricksTable.$converter2n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}spin'])),
      reportId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}report_id']),
    );
  }

  @override
  $ReportTricksTable createAlias(String alias) {
    return $ReportTricksTable(attachedDatabase, alias);
  }

  static TypeConverter<ReportStance, int> $converter0 =
      const EnumIndexConverter<ReportStance>(ReportStance.values);
  static TypeConverter<ReportDirection, int> $converter1 =
      const EnumIndexConverter<ReportDirection>(ReportDirection.values);
  static TypeConverter<ReportSpin, int> $converter2 =
      const EnumIndexConverter<ReportSpin>(ReportSpin.values);
  static TypeConverter<ReportStance?, int?> $converter0n =
      NullAwareTypeConverter.wrap($converter0);
  static TypeConverter<ReportDirection?, int?> $converter1n =
      NullAwareTypeConverter.wrap($converter1);
  static TypeConverter<ReportSpin?, int?> $converter2n =
      NullAwareTypeConverter.wrap($converter2);
}

class ReportResult extends DataClass implements Insertable<ReportResult> {
  final int id;
  final int? approachScore;
  final int? takeoffScore;
  final int? peakScore;
  final int? landingScore;
  final int? reportId;
  const ReportResult(
      {required this.id,
      this.approachScore,
      this.takeoffScore,
      this.peakScore,
      this.landingScore,
      this.reportId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || approachScore != null) {
      map['approach_score'] = Variable<int>(approachScore);
    }
    if (!nullToAbsent || takeoffScore != null) {
      map['takeoff_score'] = Variable<int>(takeoffScore);
    }
    if (!nullToAbsent || peakScore != null) {
      map['peak_score'] = Variable<int>(peakScore);
    }
    if (!nullToAbsent || landingScore != null) {
      map['landing_score'] = Variable<int>(landingScore);
    }
    if (!nullToAbsent || reportId != null) {
      map['report_id'] = Variable<int>(reportId);
    }
    return map;
  }

  ReportResultsCompanion toCompanion(bool nullToAbsent) {
    return ReportResultsCompanion(
      id: Value(id),
      approachScore: approachScore == null && nullToAbsent
          ? const Value.absent()
          : Value(approachScore),
      takeoffScore: takeoffScore == null && nullToAbsent
          ? const Value.absent()
          : Value(takeoffScore),
      peakScore: peakScore == null && nullToAbsent
          ? const Value.absent()
          : Value(peakScore),
      landingScore: landingScore == null && nullToAbsent
          ? const Value.absent()
          : Value(landingScore),
      reportId: reportId == null && nullToAbsent
          ? const Value.absent()
          : Value(reportId),
    );
  }

  factory ReportResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReportResult(
      id: serializer.fromJson<int>(json['id']),
      approachScore: serializer.fromJson<int?>(json['approachScore']),
      takeoffScore: serializer.fromJson<int?>(json['takeoffScore']),
      peakScore: serializer.fromJson<int?>(json['peakScore']),
      landingScore: serializer.fromJson<int?>(json['landingScore']),
      reportId: serializer.fromJson<int?>(json['reportId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'approachScore': serializer.toJson<int?>(approachScore),
      'takeoffScore': serializer.toJson<int?>(takeoffScore),
      'peakScore': serializer.toJson<int?>(peakScore),
      'landingScore': serializer.toJson<int?>(landingScore),
      'reportId': serializer.toJson<int?>(reportId),
    };
  }

  ReportResult copyWith(
          {int? id,
          Value<int?> approachScore = const Value.absent(),
          Value<int?> takeoffScore = const Value.absent(),
          Value<int?> peakScore = const Value.absent(),
          Value<int?> landingScore = const Value.absent(),
          Value<int?> reportId = const Value.absent()}) =>
      ReportResult(
        id: id ?? this.id,
        approachScore:
            approachScore.present ? approachScore.value : this.approachScore,
        takeoffScore:
            takeoffScore.present ? takeoffScore.value : this.takeoffScore,
        peakScore: peakScore.present ? peakScore.value : this.peakScore,
        landingScore:
            landingScore.present ? landingScore.value : this.landingScore,
        reportId: reportId.present ? reportId.value : this.reportId,
      );
  @override
  String toString() {
    return (StringBuffer('ReportResult(')
          ..write('id: $id, ')
          ..write('approachScore: $approachScore, ')
          ..write('takeoffScore: $takeoffScore, ')
          ..write('peakScore: $peakScore, ')
          ..write('landingScore: $landingScore, ')
          ..write('reportId: $reportId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, approachScore, takeoffScore, peakScore, landingScore, reportId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReportResult &&
          other.id == this.id &&
          other.approachScore == this.approachScore &&
          other.takeoffScore == this.takeoffScore &&
          other.peakScore == this.peakScore &&
          other.landingScore == this.landingScore &&
          other.reportId == this.reportId);
}

class ReportResultsCompanion extends UpdateCompanion<ReportResult> {
  final Value<int> id;
  final Value<int?> approachScore;
  final Value<int?> takeoffScore;
  final Value<int?> peakScore;
  final Value<int?> landingScore;
  final Value<int?> reportId;
  const ReportResultsCompanion({
    this.id = const Value.absent(),
    this.approachScore = const Value.absent(),
    this.takeoffScore = const Value.absent(),
    this.peakScore = const Value.absent(),
    this.landingScore = const Value.absent(),
    this.reportId = const Value.absent(),
  });
  ReportResultsCompanion.insert({
    this.id = const Value.absent(),
    this.approachScore = const Value.absent(),
    this.takeoffScore = const Value.absent(),
    this.peakScore = const Value.absent(),
    this.landingScore = const Value.absent(),
    this.reportId = const Value.absent(),
  });
  static Insertable<ReportResult> custom({
    Expression<int>? id,
    Expression<int>? approachScore,
    Expression<int>? takeoffScore,
    Expression<int>? peakScore,
    Expression<int>? landingScore,
    Expression<int>? reportId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (approachScore != null) 'approach_score': approachScore,
      if (takeoffScore != null) 'takeoff_score': takeoffScore,
      if (peakScore != null) 'peak_score': peakScore,
      if (landingScore != null) 'landing_score': landingScore,
      if (reportId != null) 'report_id': reportId,
    });
  }

  ReportResultsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? approachScore,
      Value<int?>? takeoffScore,
      Value<int?>? peakScore,
      Value<int?>? landingScore,
      Value<int?>? reportId}) {
    return ReportResultsCompanion(
      id: id ?? this.id,
      approachScore: approachScore ?? this.approachScore,
      takeoffScore: takeoffScore ?? this.takeoffScore,
      peakScore: peakScore ?? this.peakScore,
      landingScore: landingScore ?? this.landingScore,
      reportId: reportId ?? this.reportId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (approachScore.present) {
      map['approach_score'] = Variable<int>(approachScore.value);
    }
    if (takeoffScore.present) {
      map['takeoff_score'] = Variable<int>(takeoffScore.value);
    }
    if (peakScore.present) {
      map['peak_score'] = Variable<int>(peakScore.value);
    }
    if (landingScore.present) {
      map['landing_score'] = Variable<int>(landingScore.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<int>(reportId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportResultsCompanion(')
          ..write('id: $id, ')
          ..write('approachScore: $approachScore, ')
          ..write('takeoffScore: $takeoffScore, ')
          ..write('peakScore: $peakScore, ')
          ..write('landingScore: $landingScore, ')
          ..write('reportId: $reportId')
          ..write(')'))
        .toString();
  }
}

class $ReportResultsTable extends ReportResults
    with TableInfo<$ReportResultsTable, ReportResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportResultsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _approachScoreMeta =
      const VerificationMeta('approachScore');
  @override
  late final GeneratedColumn<int> approachScore = GeneratedColumn<int>(
      'approach_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _takeoffScoreMeta =
      const VerificationMeta('takeoffScore');
  @override
  late final GeneratedColumn<int> takeoffScore = GeneratedColumn<int>(
      'takeoff_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _peakScoreMeta = const VerificationMeta('peakScore');
  @override
  late final GeneratedColumn<int> peakScore = GeneratedColumn<int>(
      'peak_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _landingScoreMeta =
      const VerificationMeta('landingScore');
  @override
  late final GeneratedColumn<int> landingScore = GeneratedColumn<int>(
      'landing_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _reportIdMeta = const VerificationMeta('reportId');
  @override
  late final GeneratedColumn<int> reportId = GeneratedColumn<int>(
      'report_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, approachScore, takeoffScore, peakScore, landingScore, reportId];
  @override
  String get aliasedName => _alias ?? 'report_results';
  @override
  String get actualTableName => 'report_results';
  @override
  VerificationContext validateIntegrity(Insertable<ReportResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('approach_score')) {
      context.handle(
          _approachScoreMeta,
          approachScore.isAcceptableOrUnknown(
              data['approach_score']!, _approachScoreMeta));
    }
    if (data.containsKey('takeoff_score')) {
      context.handle(
          _takeoffScoreMeta,
          takeoffScore.isAcceptableOrUnknown(
              data['takeoff_score']!, _takeoffScoreMeta));
    }
    if (data.containsKey('peak_score')) {
      context.handle(_peakScoreMeta,
          peakScore.isAcceptableOrUnknown(data['peak_score']!, _peakScoreMeta));
    }
    if (data.containsKey('landing_score')) {
      context.handle(
          _landingScoreMeta,
          landingScore.isAcceptableOrUnknown(
              data['landing_score']!, _landingScoreMeta));
    }
    if (data.containsKey('report_id')) {
      context.handle(_reportIdMeta,
          reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportResult(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      approachScore: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}approach_score']),
      takeoffScore: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}takeoff_score']),
      peakScore: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}peak_score']),
      landingScore: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}landing_score']),
      reportId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}report_id']),
    );
  }

  @override
  $ReportResultsTable createAlias(String alias) {
    return $ReportResultsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $TodosTable todos = $TodosTable(this);
  late final $ReportsTable reports = $ReportsTable(this);
  late final $ReportTricksTable reportTricks = $ReportTricksTable(this);
  late final $ReportResultsTable reportResults = $ReportResultsTable(this);
  late final TodosDao todosDao = TodosDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [todos, reports, reportTricks, reportResults];
}
