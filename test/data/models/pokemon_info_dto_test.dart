import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/data/dtos/pokemon_info_dto.dart';
import 'package:pokemon_app/domain/entities/pokemon_info.dart';

void main() {
  group('PokemonInfoDto', () {
    const json = {
      'name': 'bulbasaur',
      'url': 'https://pokeapi.co/api/v2/pokemon/1/',
    };

    test('fromJson should create correct PokemonInfoDto', () {
      final dto = PokemonInfoDto.fromJson(json);

      expect(dto.name, 'bulbasaur');
      expect(dto.url, 'https://pokeapi.co/api/v2/pokemon/1/');
    });

    test('toDomain should convert to PokemonInfo correctly', () {
      final dto = PokemonInfoDto.fromJson(json);
      final domain = dto.toDomain();

      expect(domain, isA<PokemonInfo>());
      expect(domain.name, 'bulbasaur');
      expect(domain.url, 'https://pokeapi.co/api/v2/pokemon/1/');
    });

    test('PokemonInfo domain entity should expose correct id and sprites', () {
      final domain = PokemonInfoDto.fromJson(json).toDomain();

      expect(domain.id, 1);
      expect(
        domain.thumbSprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );
      expect(
        domain.artwork,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      );
    });
  });
}
