// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unexpected error`
  String get unexpectedError {
    return Intl.message(
      'Unexpected error',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message('Sign up', name: 'signUp', desc: '', args: []);
  }

  /// `Log In`
  String get logIn {
    return Intl.message('Log In', name: 'logIn', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `The password reset link has been sent to your email.`
  String get sentResetLink {
    return Intl.message(
      'The password reset link has been sent to your email.',
      name: 'sentResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Due: {formattedDate}`
  String dueFormattedDate(Object formattedDate) {
    return Intl.message(
      'Due: $formattedDate',
      name: 'dueFormattedDate',
      desc: '',
      args: [formattedDate],
    );
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Select due date`
  String get selectDueDate {
    return Intl.message(
      'Select due date',
      name: 'selectDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Fill in all fields`
  String get fillInAllFields {
    return Intl.message(
      'Fill in all fields',
      name: 'fillInAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Tasks`
  String get tasks {
    return Intl.message('Tasks', name: 'tasks', desc: '', args: []);
  }

  /// `Go back`
  String get goBack {
    return Intl.message('Go back', name: 'goBack', desc: '', args: []);
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Arrange alphabetically`
  String get arrangeAlphabetically {
    return Intl.message(
      'Arrange alphabetically',
      name: 'arrangeAlphabetically',
      desc: '',
      args: [],
    );
  }

  /// `Due deadline: {daysLeft} day(s)`
  String dueDeadlineDaysleftDays(Object daysLeft) {
    return Intl.message(
      'Due deadline: $daysLeft day(s)',
      name: 'dueDeadlineDaysleftDays',
      desc: '',
      args: [daysLeft],
    );
  }

  /// `Task: {title} is created`
  String taskTitleIsCreated(Object title) {
    return Intl.message(
      'Task: $title is created',
      name: 'taskTitleIsCreated',
      desc: '',
      args: [title],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
