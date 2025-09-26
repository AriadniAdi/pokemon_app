import 'package:pokemon_app/domain/entities/pokemon_info.dart';

class PokemonInfoDto {
  final String name;
  final String url;

  const PokemonInfoDto({
    required this.name,
    required this.url,
  });

  factory PokemonInfoDto.fromJson(Map<String, dynamic> json) {
    return PokemonInfoDto(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  PokemonInfo toDomain() {
    return PokemonInfo(
      name: name,
      url: url,
    );
  }
}
