import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/data/dtos/pokemon_info_dto.dart';
import 'package:pokemon_app/domain/entities/pokemon_info.dart';

void main() {
  group('PokemonInfoDto', () {
    final sampleJson = {
      'name': 'bulbasaur',
      'url': 'https://pokeapi.co/api/v2/pokemon/1/',
    };

    test('fromJson deve parsear JSON corretamente', () {
      final dto = PokemonInfoDto.fromJson(sampleJson);

      expect(dto.name, 'bulbasaur');
      expect(dto.url, 'https://pokeapi.co/api/v2/pokemon/1/');
    });

    test('toDomain deve converter corretamente para PokemonInfo', () {
      final dto = PokemonInfoDto.fromJson(sampleJson);
      final entity = dto.toDomain();

      expect(entity, isA<PokemonInfo>());
      expect(entity.name, dto.name);
      expect(entity.url, dto.url);
      expect(entity.id, 1);
      expect(
        entity.thumbSprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );
      expect(
        entity.artwork,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      );
    });

    test('dois DTOs com mesmo conteúdo devem ser equivalentes nos valores', () {
      final dto1 = PokemonInfoDto.fromJson(sampleJson);
      final dto2 = PokemonInfoDto.fromJson(sampleJson);

      expect(dto1.name, dto2.name);
      expect(dto1.url, dto2.url);
    });
  });
}
