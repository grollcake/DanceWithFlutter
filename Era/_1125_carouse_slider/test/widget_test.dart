void main() {
  List<dynamic> numbers = [];

  for (int i = 0; i < 5; i++) {
    numbers.add((List.generate(45, (index) => ++index)..shuffle()).sublist(0, 6));
  }

  for (List<int> item in numbers) {
    print(item);
  }
}
