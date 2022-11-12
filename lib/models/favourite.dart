class Favourite {
  late String id;

  Favourite({required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  Favourite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
  }
}
