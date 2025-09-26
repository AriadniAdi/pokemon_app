import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_app/data/repositories/pokemon_repository_impl.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late PokemonRepositoryImpl repository;

  setUp(() {
    mockDio = MockDio();
    repository = PokemonRepositoryImpl(mockDio);
  });

  test('should fetch pokemon details from API', () async {
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        data: {
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
            'front_default': 'https://example.com/sprite.png',
            'other': {
              'official-artwork': {
                'front_default': 'https://example.com/artwork.png',
              }
            }
          }
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = await repository.getPokemonDetails('1');

    expect(result.id, 1);
    expect(result.name, 'bulbasaur');
    expect(result.types, contains('grass'));
    expect(result.artwork, isNotEmpty);
  });
}
