import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_app/data/services/poke_api_service.dart';
import 'package:pokemon_app/data/dtos/pokemon_info_dto.dart';
import 'package:pokemon_app/data/dtos/pokemon_details_dto.dart';

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late MockDio mockDio;
  late PokeApiService service;

  setUp(() {
    mockDio = MockDio();
    service = PokeApiService(mockDio);
  });

  group('PokeApiService', () {
    test('fetchPokemonPage retorna lista de PokemonInfoDto', () async {
      final response = MockResponse<Map<String, dynamic>>();
      when(() => response.data).thenReturn({
        "results": [
          {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"}
        ],
        "next": "next-url",
        "previous": null,
      });

      when(() => mockDio.get(
            'pokemon',
            queryParameters: {"limit": 20, "offset": 0},
          )).thenAnswer((_) async => response);

      final (results, next, prev) = await service.fetchPokemonPage();

      expect(results, isA<List<PokemonInfoDto>>());
      expect(results.first.name, "bulbasaur");
      expect(next, "next-url");
      expect(prev, isNull);
    });

    test('fetchPokemonDetails retorna PokemonDetailsDto', () async {
      final response = MockResponse<Map<String, dynamic>>();
      when(() => response.data).thenReturn({
        "id": 25,
        "name": "pikachu",
        "height": 4,
        "weight": 60,
        "types": [
          {
            "type": {"name": "electric"}
          }
        ],
        "abilities": [
          {
            "ability": {"name": "static"}
          },
          {
            "ability": {"name": "lightning-rod"}
          }
        ],
        "sprites": {
          "front_default": "sprite.png",
          "other": {
            "official-artwork": {"front_default": "artwork.png"}
          }
        }
      });

      when(() => mockDio.get('pokemon/pikachu'))
          .thenAnswer((_) async => response);

      final result = await service.fetchPokemonDetails('pikachu');

      expect(result, isA<PokemonDetailsDto>());
      expect(result.name, "pikachu");
      expect(result.types, contains("electric"));
      expect(result.abilities, contains("static"));
      expect(result.artwork, "artwork.png");
    });

    test('fetchPokemonDetails lida com erro da API', () async {
      when(() => mockDio.get('pokemon/missingno'))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () => service.fetchPokemonDetails('missingno'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
