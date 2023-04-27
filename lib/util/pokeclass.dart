class Pokemon {
  final String name;
  final String id;
  final String imageurl;
  final String xdescription;
  final int attack;
  final int defense;
  final int special_attack;
  final int special_defense;
  final int speed;
  final int total;

  const Pokemon({
    required this.name,
    required this.id,
    required this.imageurl,
    required this.xdescription,
    required this.attack,
    required this.defense,
    required this.special_attack,
    required this.special_defense,
    required this.speed,
    required this.total,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String,
      id: json['id'] as String,
      imageurl: json["imageurl"] as String,
      xdescription: json['xdescription'],
      attack: json['attack'],
      defense: json['defense'],
      special_attack: json['special_attack'],
      special_defense: json['special_defense'],
      speed: json['speed'],
      total: json['total'],
    );
  }
}
