class Pokemon {
  final String id;
  final String name;

  Pokemon({required this.id, required this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(id: json['id'], name: json['name']);
  }
}
