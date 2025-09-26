import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/usecases/get_random_pokemon.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository mockRepo;
  late GetRandomPokemon usecase;

  setUp(() {
    mockRepo = MockPokemonRepository();
    usecase = GetRandomPokemon(mockRepo);
  });

  test('should return a Pokemon from repository', () async {
    const pokemon = Pokemon(
      id: 25,
      name: 'pikachu',
      height: 0.4,
      weight: 6.0,
      types: ['electric'],
      abilities: ['static'],
      artwork: 'https://example.com/pikachu.png',
    );

    when(() => mockRepo.getRandomPokemon()).thenAnswer((_) async => pokemon);

    final result = await usecase();

    expect(result, pokemon);
    verify(() => mockRepo.getRandomPokemon()).called(1);
  });
}
