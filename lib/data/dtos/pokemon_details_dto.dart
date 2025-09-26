import 'package:pokemon_app/domain/entities/pokemon.dart';

class PokemonDetailsDto {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final String sprite;
  final String artwork;

  PokemonDetailsDto({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.sprite,
    required this.artwork,
  });

  factory PokemonDetailsDto.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;

    return PokemonDetailsDto(
      id: id,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: (json['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((a) => a['ability']['name'] as String)
          .toList(),
      sprite: json['sprites']?['front_default'] as String? ?? '',
      artwork: json['sprites']?['other']?['official-artwork']
              ?['front_default'] ??
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }

  Pokemon toDomain() {
    return Pokemon(
      id: id,
      name: name,
      height: height / 10.0,
      weight: weight / 10.0,
      types: types,
      abilities: abilities,
      artwork: artwork,
    );
  }

  double get heightMeters => height / 10.0;
  double get weightKg => weight / 10.0;
}
