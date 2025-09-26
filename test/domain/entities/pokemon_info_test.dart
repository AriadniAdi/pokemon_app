import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/domain/entities/pokemon_info.dart';

void main() {
  group('PokemonInfo', () {
    const bulba = PokemonInfo(
      name: 'bulbasaur',
      url: 'https://pokeapi.co/api/v2/pokemon/1/',
    );

    test('id deve extrair número correto da URL', () {
      expect(bulba.id, 1);
    });

    test('thumbSprite deve gerar URL correta', () {
      expect(
        bulba.thumbSprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );
    });

    test('artwork deve gerar URL correta', () {
      expect(
        bulba.artwork,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
      );
    });

    test('funciona com outro Pokémon (pikachu)', () {
      const pika = PokemonInfo(
        name: 'pikachu',
        url: 'https://pokeapi.co/api/v2/pokemon/25/',
      );

      expect(pika.id, 25);
      expect(
        pika.thumbSprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
      );
      expect(
        pika.artwork,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
      );
    });

    test('id deve falhar se a URL não contiver número válido', () {
      const invalid = PokemonInfo(
        name: 'failmon',
        url: 'https://pokeapi.co/api/v2/pokemon/',
      );

      expect(() => invalid.id, throwsFormatException);
    });
  });
}
