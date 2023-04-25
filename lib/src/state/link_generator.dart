import 'package:dartpad_flutter/src/domain/dartpad.dart';
import 'package:flutter/material.dart';

class LinkGenerator extends ChangeNotifier {
  DartPadPage? _selectedPage;

  DartPadPage? get selectedPage => _selectedPage;

  void setPage(DartPadPage value) {
    if (selectedPage == value) return;

    _selectedPage = value;

    _split = null;

    _theme = null;

    _run = null;

    _gistId = null;

    _githubInfo = null;

    notifyListeners();
  }

  int? _split;

  int? get split => _split;

  void setSplit(int value) {
    if (split == value) return;

    _split = value;

    notifyListeners();
  }

  DartPadTheme? _theme;

  DartPadTheme? get theme => _theme;

  void setTheme(DartPadTheme value) {
    if (theme == value) return;

    _theme = value;

    notifyListeners();
  }

  bool? _run;

  bool? get run => _run;

  void setRun(bool value) {
    if (run == value) return;

    _run = value;

    notifyListeners();
  }

  String? _gistId;

  String? get gistId => _gistId;

  void setGistId(String value) {
    if (gistId == value) return;

    _gistId = value;

    notifyListeners();
  }

  DartPadGithubRepoInfo? _githubInfo;

  DartPadGithubRepoInfo? get githubInfo => _githubInfo;

  void setGithubInfo(DartPadGithubRepoInfo value) {
    if (githubInfo == value) return;

    _githubInfo = value;

    notifyListeners();
  }

  Uri? buildUri() {
    if (_selectedPage == null) return null;

    return Uri.https(
      'dartpad.dev',
      _selectedPage!.toPath(),
      <String, String>{
        if (_split != null) 'split': split!.toString(),
        if (_theme != null) 'theme': _theme!.toString().split('.').last,
        if (_run != null) 'run': _run!.toString(),
        if (_gistId != null) 'id': gistId.toString() else ..._githubInfo?.toQuery() ?? {},
      },
    );
  }
}
