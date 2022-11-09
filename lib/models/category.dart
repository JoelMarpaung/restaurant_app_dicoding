import 'dart:convert';

class Category {
  Category({
    required this.name,
  });

  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );
}

List<Category> parseCategories(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Category.fromJson(json)).toList();
}
