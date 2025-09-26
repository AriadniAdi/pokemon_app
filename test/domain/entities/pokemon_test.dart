import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

void main() {
  group('Pokemon Entity', () {
    test('should create a valid Pokemon entity', () {
      const pokemon = Pokemon(
        id: 1,
        name: 'bulbasaur',
        height: 0.7,
        weight: 6.9,
        types: ['grass', 'poison'],
        abilities: ['overgrow', 'chlorophyll'],
        artwork: 'https://example.com/bulbasaur.png',
      );

      expect(pokemon.id, 1);
      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.types, contains('grass'));
      expect(pokemon.artwork, isNotEmpty);
    });
  });
}
