import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/data/dtos/pokemon_details_dto.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

void main() {
  group('PokemonDetailsDto', () {
    final json = {
      'id': 1,
      'name': 'bulbasaur',
      'height': 7,
      'weight': 69,
      'types': [
        {
          'type': {'name': 'grass'}
        },
        {
          'type': {'name': 'poison'}
        },
      ],
      'abilities': [
        {
          'ability': {'name': 'overgrow'}
        },
        {
          'ability': {'name': 'chlorophyll'}
        },
      ],
      'sprites': {
        'front_default': 'https://example.com/front.png',
        'other': {
          'official-artwork': {
            'front_default': 'https://example.com/artwork.png',
          }
        }
      }
    };

    test('fromJson should parse correctly', () {
      final dto = PokemonDetailsDto.fromJson(json);

      expect(dto.id, 1);
      expect(dto.name, 'bulbasaur');
      expect(dto.height, 7);
      expect(dto.weight, 69);
      expect(dto.types, ['grass', 'poison']);
      expect(dto.abilities, ['overgrow', 'chlorophyll']);
      expect(dto.sprite, 'https://example.com/front.png');
      expect(dto.artwork, 'https://example.com/artwork.png');
    });

    test('toDomain should convert to Pokemon entity correctly', () {
      final dto = PokemonDetailsDto.fromJson(json);
      final pokemon = dto.toDomain();

      expect(pokemon, isA<Pokemon>());
      expect(pokemon.id, 1);
      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.height, 0.7);
      expect(pokemon.weight, 6.9);
      expect(pokemon.types, ['grass', 'poison']);
      expect(pokemon.abilities, ['overgrow', 'chlorophyll']);
      expect(pokemon.artwork, 'https://example.com/artwork.png');
    });

    test('heightMeters and weightKg should return correct conversions', () {
      final dto = PokemonDetailsDto.fromJson(json);

      expect(dto.heightMeters, 0.7);
      expect(dto.weightKg, 6.9);
    });

    test('should fallback to default artwork URL if not present in JSON', () {
      final jsonWithoutArtwork = {
        ...json,
        'sprites': {
          'front_default': 'https://example.com/front.png',
          'other': {}
        }
      };

      final dto = PokemonDetailsDto.fromJson(jsonWithoutArtwork);

      expect(
        dto.artwork,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      );
    });
  });
}
