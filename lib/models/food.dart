import 'dart:convert';

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> food) => Food(
        name: food['name'],
      );
}

List<Food> parseFoods(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Food.fromJson(json)).toList();
}
