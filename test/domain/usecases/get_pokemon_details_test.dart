import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';
import 'package:pokemon_app/domain/usecases/get_pokemon_details.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository mockRepo;
  late GetPokemonDetails usecase;

  setUp(() {
    mockRepo = MockPokemonRepository();
    usecase = GetPokemonDetails(mockRepo);
  });

  const tPokemon = Pokemon(
    id: 1,
    name: 'bulbasaur',
    height: 0.7,
    weight: 6.9,
    types: ['grass', 'poison'],
    abilities: ['overgrow', 'chlorophyll'],
    artwork: 'https://example.com/bulbasaur.png',
  );

  test('should return Pokemon details from repository', () async {
    when(() => mockRepo.getPokemonDetails('1'))
        .thenAnswer((_) async => tPokemon);

    final result = await usecase('1');

    expect(result, tPokemon);
    verify(() => mockRepo.getPokemonDetails('1')).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
