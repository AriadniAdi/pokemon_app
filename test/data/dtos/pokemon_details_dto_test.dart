import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/data/dtos/pokemon_details_dto.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

void main() {
  group('PokemonDetailsDto', () {
    final sampleJson = {
      'id': 25,
      'name': 'pikachu',
      'height': 4,
      'weight': 60,
      'types': [
        {
          'type': {'name': 'electric'}
        },
      ],
      'abilities': [
        {
          'ability': {'name': 'static'}
        },
        {
          'ability': {'name': 'lightning-rod'}
        },
      ],
      'sprites': {
        'front_default': 'https://raw.githubusercontent.com/front.png',
        'other': {
          'official-artwork': {
            'front_default':
                'https://raw.githubusercontent.com/official-artwork.png',
          }
        }
      }
    };

    test('fromJson deve parsear JSON corretamente', () {
      final dto = PokemonDetailsDto.fromJson(sampleJson);

      expect(dto.id, 25);
      expect(dto.name, 'pikachu');
      expect(dto.height, 4);
      expect(dto.weight, 60);
      expect(dto.types, ['electric']);
      expect(dto.abilities, ['static', 'lightning-rod']);
      expect(dto.sprite, 'https://raw.githubusercontent.com/front.png');
      expect(dto.artwork,
          'https://raw.githubusercontent.com/official-artwork.png');
    });

    test('fromJson deve usar fallback de artwork quando não existir', () {
      final jsonWithoutArtwork = Map<String, dynamic>.from(sampleJson);
      jsonWithoutArtwork['sprites'] = {}; // remove sprites

      final dto = PokemonDetailsDto.fromJson(jsonWithoutArtwork);

      expect(
        dto.artwork,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
      );
    });

    test('toDomain deve converter corretamente para entidade Pokemon', () {
      final dto = PokemonDetailsDto.fromJson(sampleJson);
      final pokemon = dto.toDomain();

      expect(pokemon, isA<Pokemon>());
      expect(pokemon.id, dto.id);
      expect(pokemon.name, dto.name);
      expect(pokemon.height, dto.height / 10.0);
      expect(pokemon.weight, dto.weight / 10.0);
      expect(pokemon.types, dto.types);
      expect(pokemon.abilities, dto.abilities);
      expect(pokemon.artwork, dto.artwork);
    });

    test('heightMeters e weightKg devem converter valores corretamente', () {
      final dto = PokemonDetailsDto.fromJson(sampleJson);

      expect(dto.heightMeters, 0.4);
      expect(dto.weightKg, 6.0);
    });
  });
}
