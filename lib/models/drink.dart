import 'dart:convert';

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> food) => Drink(
        name: food['name'],
      );
}

List<Drink> parseFoods(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Drink.fromJson(json)).toList();
}
