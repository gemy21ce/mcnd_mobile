import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd', "en-US");
final DateFormat _timeFormatter = DateFormat('HH:mm:ss', "en-US");

class McndDateConverter implements JsonConverter<DateTime, String> {
  const McndDateConverter();

  @override
  DateTime fromJson(String json) => _dateFormatter.parse(json);

  @override
  String toJson(DateTime object) => _dateFormatter.format(object);
}

class McndTimeConverter implements JsonConverter<DateTime, String> {
  const McndTimeConverter();

  @override
  DateTime fromJson(String json) => _timeFormatter.parse(json);

  @override
  String toJson(DateTime object) => _timeFormatter.format(object);
}
