/// Типы страниц в DartPad.
enum DartPadPage {
  /// Просто Dart с консолью справа.
  dart,

  /// Тоже Dart, но консоль снизу.

  inlineDart,

  /// Dart + Flutter.

  flutter,

  /// Dart + Flutter, но кода сразу не видно

  flutterShowcase,

  /// Редактор HTML+CSS+Dart (кому он нужен...)
  html,

  /// Воркшоп.
  workshops,
}

extension DartPadPageExt on DartPadPage {
  String toPath() {
    var result = '/';

    switch (this) {
      case DartPadPage.dart:
        result += 'embed-dart';
        break;
      case DartPadPage.inlineDart:
        result += 'embed-inline';
        break;
      case DartPadPage.flutter:
        result += 'embed-flutter';
        break;
      case DartPadPage.flutterShowcase:
        result += 'embed-flutter_showcase';
        break;
      case DartPadPage.html:
        result += 'embed-html';
        break;
      case DartPadPage.workshops:
        result += 'workshops';
        break;
    }

    result += '.html';

    return result;
  }

  String toTitleString() {
    switch (this) {
      case DartPadPage.dart:
        return 'Dart';
      case DartPadPage.inlineDart:
        return 'Inline Dart';
      case DartPadPage.flutter:
        return 'Flutter';
      case DartPadPage.flutterShowcase:
        return 'Flutter Showcase';
      case DartPadPage.html:
        return 'HTML';
      case DartPadPage.workshops:
        return 'Workshops';
    }
  }
}

/// Типы query, что мы можем
/// указывать в DartPad.
enum DartPadField {
  split,
  theme,
  run,

  /// Только репозиторий

  githubRepository,

  /// Gist или Github репозиторий

  github,
}

enum DartPadTheme { light, dark }

extension DartPadThemeExt on DartPadTheme {
  String toTitleString() {
    switch (this) {
      case DartPadTheme.light:
        return 'Light';
      case DartPadTheme.dark:
        return 'Dark';
    }
  }
}

/// Информация для формирования ссылки,
/// ссылающаяся на репозиторий
class DartPadGithubRepoInfo {
  /// Имя пользователя на Github.
  final String userName;

  /// Название *публичного* репозитория.
  final String repoName;

  /// Путь к папке с нужными файлами.
  final String path;

  /// Название ветки.
  final String? reference;

  DartPadGithubRepoInfo({
    required this.userName,
    required this.repoName,
    required this.path,
    this.reference,
  });

  Map<String, String> toQuery() {
    return {
      'gh_owner': userName,
      'gh_repo': repoName,
      'gh_path': path,
      if (reference != null) 'gh_ref': reference!,
    };
  }
}

/// Поля, что будут доступны для ввода.
final Map<DartPadPage, List<DartPadField>> dartPadFieldsMap = {
  DartPadPage.dart: [
    DartPadField.theme,
    DartPadField.run,
    DartPadField.split,
    DartPadField.github,
  ],
  DartPadPage.inlineDart: [
    DartPadField.theme,
    DartPadField.run,
    DartPadField.split,
    DartPadField.github,
  ],
  DartPadPage.flutter: [
    DartPadField.theme,
    DartPadField.run,
    DartPadField.split,
    DartPadField.github,
  ],
  DartPadPage.flutterShowcase: [
    DartPadField.theme,
    DartPadField.run,
    DartPadField.github,
  ],
  DartPadPage.html: [
    DartPadField.theme,
    DartPadField.run,
    DartPadField.split,
  ],
  DartPadPage.workshops: [
    DartPadField.githubRepository,
  ],
};
