void main() {
  try {
    final str = stringify(2, 3);

    if (str == '2 3') {
      _result(true);
    } else {
      _result(false, ['Пока что не то, но ты в верном направлении!', 'Keep trying!']);
    }
  } catch (e) {
    _result(false, ['Tried calling stringify(2, 3), but received an exception: ${e.runtimeType}']);
  }
}
