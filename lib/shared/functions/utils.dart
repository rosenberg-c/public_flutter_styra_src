int _weights = 10;

getWeightList() {
  List<int> _weightList = List<int>.generate(
    10,
    (int index) => (index + 1) * _weights,
  );
  return _weightList;
  // static List<int> _weightList = [100, 200];
}
