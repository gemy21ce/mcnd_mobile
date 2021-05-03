import 'dart:convert';
import 'dart:io';

Future<dynamic?> readJsonFromFile(String path) async => json.decode(await readStringFromFile(path));

Future<String> readStringFromFile(String path) => readFile(path).readAsString();

File readFile(String path) => File('test/_test_shared/$path');
