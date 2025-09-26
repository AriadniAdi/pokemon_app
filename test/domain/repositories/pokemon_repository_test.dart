import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository mockRepo;

  setUp(() {
    mockRepo = MockPokemonRepository();
  });

  const pikachu = Pokemon(
    id: 25,
    name: 'pikachu',
    height: 0.4,
    weight: 6.0,
    types: ['electric'],
    abilities: ['static', 'lightning-rod'],
    artwork:
        'https://raw.githubusercontent.com/pokeapi/sprites/master/sprites/pokemon/other/official-artwork/25.png',
  );

  group('PokemonRepository contract', () {
    test('getPokemonDetails retorna Pokémon esperado', () async {
      when(() => mockRepo.getPokemonDetails('pikachu'))
          .thenAnswer((_) async => pikachu);

      final result = await mockRepo.getPokemonDetails('pikachu');

      expect(result.name, equals('pikachu'));
      expect(result.id, equals(25));
      verify(() => mockRepo.getPokemonDetails('pikachu')).called(1);
    });

    test('getRandomPokemon retorna Pokémon esperado', () async {
      when(() => mockRepo.getRandomPokemon()).thenAnswer((_) async => pikachu);

      final result = await mockRepo.getRandomPokemon();

      expect(result, isA<Pokemon>());
      expect(result.name, 'pikachu');
      verify(() => mockRepo.getRandomPokemon()).called(1);
    });

    test('getPokemonDetails lança erro em caso de falha', () async {
      when(() => mockRepo.getPokemonDetails('failmon'))
          .thenThrow(Exception('Not found'));

      expect(
        () => mockRepo.getPokemonDetails('failmon'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
