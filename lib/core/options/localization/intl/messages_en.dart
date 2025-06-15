// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(daysLeft) => "Due deadline: ${daysLeft} day(s)";

  static String m1(formattedDate) => "Due: ${formattedDate}";

  static String m2(title) => "Task: ${title} is created";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "arrangeAlphabetically": MessageLookupByLibrary.simpleMessage(
      "Arrange alphabetically",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "dueDeadlineDaysleftDays": m0,
    "dueFormattedDate": m1,
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "fillInAllFields": MessageLookupByLibrary.simpleMessage(
      "Fill in all fields",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "goBack": MessageLookupByLibrary.simpleMessage("Go back"),
    "logIn": MessageLookupByLibrary.simpleMessage("Log In"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "selectDueDate": MessageLookupByLibrary.simpleMessage("Select due date"),
    "send": MessageLookupByLibrary.simpleMessage("Send"),
    "sentResetLink": MessageLookupByLibrary.simpleMessage(
      "The password reset link has been sent to your email.",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
    "taskTitleIsCreated": m2,
    "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
    "title": MessageLookupByLibrary.simpleMessage("Title"),
    "unexpectedError": MessageLookupByLibrary.simpleMessage("Unexpected error"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
  };
}
