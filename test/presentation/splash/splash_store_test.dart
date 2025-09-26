import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/usecases/get_random_pokemon.dart';
import 'package:pokemon_app/presentation/splash/splash_store.dart';

class MockGetRandomPokemon extends Mock implements GetRandomPokemon {}

void main() {
  late SplashStore store;
  late MockGetRandomPokemon mockGetRandomPokemon;

  setUp(() {
    mockGetRandomPokemon = MockGetRandomPokemon();
    store = SplashStore(mockGetRandomPokemon);
  });

  test('should load random pokemon successfully', () async {
    const pokemon = Pokemon(
      id: 1,
      name: 'bulbasaur',
      height: 0.7,
      weight: 6.9,
      types: ['grass', 'poison'],
      abilities: ['overgrow'],
      artwork: 'https://example.com/bulbasaur.png',
    );

    when(() => mockGetRandomPokemon()).thenAnswer((_) async => pokemon);

    await store.loadRandomPokemon();

    expect(store.isLoading, false);
    expect(store.errorMessage, isNull);
    expect(store.pokemon, equals(pokemon));
  });

  test('should set errorMessage when load fails', () async {
    when(() => mockGetRandomPokemon()).thenThrow(Exception('fail'));

    await store.loadRandomPokemon();

    expect(store.isLoading, false);
    expect(store.pokemon, isNull);
    expect(store.errorMessage, isNotNull);
  });
}
