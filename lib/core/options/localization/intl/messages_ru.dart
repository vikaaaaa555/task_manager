// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(formattedDate) => "До: ${formattedDate}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "arrangeAlphabetically": MessageLookupByLibrary.simpleMessage(
      "Расположить по алфавиту",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "description": MessageLookupByLibrary.simpleMessage("Описание"),
    "dueFormattedDate": m0,
    "email": MessageLookupByLibrary.simpleMessage("Почта"),
    "fillInAllFields": MessageLookupByLibrary.simpleMessage(
      "Заполните все поля",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "goBack": MessageLookupByLibrary.simpleMessage("Назад"),
    "logIn": MessageLookupByLibrary.simpleMessage("Вход"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "selectDueDate": MessageLookupByLibrary.simpleMessage(
      "Выберите дату окончания",
    ),
    "send": MessageLookupByLibrary.simpleMessage("Отправить"),
    "sentResetLink": MessageLookupByLibrary.simpleMessage(
      "Ссылка для сброса пароля отправлена на почту.",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "tasks": MessageLookupByLibrary.simpleMessage("Задачи"),
    "title": MessageLookupByLibrary.simpleMessage("Заголовок"),
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "Непредвиденная ошибка",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Обновить"),
  };
}
