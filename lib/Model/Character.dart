class Character {
  final int id;
  final String name;
  final String species;
  final String gender;
  final String image;
  final String status;
  final String location;
  final int episodes;

  const Character(
      {required this.status,
      required this.location,
      required this.episodes,
      required this.id,
      required this.name,
      required this.gender,
      required this.species,
      required this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        species: json['species'],
        image: json['image'],
        status: json['status'],
        location: json['location']['name'],
        episodes: json['episode'].length);
  }
}
