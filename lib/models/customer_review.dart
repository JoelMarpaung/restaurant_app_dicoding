import 'dart:convert';

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}

List<CustomerReview> parseCustomerReviews(String? json) {
  if (json == null) {
    return [];
  }

  var data = jsonDecode(json);
  final List parsed = data['customerReviews'] as List;
  return parsed.map((json) => CustomerReview.fromJson(json)).toList();
}