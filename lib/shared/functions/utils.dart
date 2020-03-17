generateIntList({int start, int length, int steps}) {
  List<int> _weightList = List<int>.generate(
    length,
    (int index) => (index + start) * steps,
  );
  return _weightList;
}

generateWeights() {
  return generateIntList(start: 2, length: 18, steps: 50);
}
