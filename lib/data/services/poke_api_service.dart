import 'package:dio/dio.dart';
import 'package:pokemon_app/data/dtos/pokemon_info_dto.dart';
import 'package:pokemon_app/data/dtos/pokemon_details_dto.dart';

class PokeApiService {
  final Dio _dio;

  PokeApiService([Dio? dio])
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://pokeapi.co/api/v2/',
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 15),
              ),
            );

  Future<(List<PokemonInfoDto>, String? next, String? prev)> fetchPokemonPage({
    int limit = 20,
    int offset = 0,
  }) async {
    final res = await _dio.get(
      'pokemon',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final data = res.data as Map<String, dynamic>;
    final results = (data['results'] as List)
        .map((e) => PokemonInfoDto.fromJson(e as Map<String, dynamic>))
        .toList();

    return (results, data['next'] as String?, data['previous'] as String?);
  }

  Future<PokemonDetailsDto> fetchPokemonDetails(String idOrName) async {
    final res = await _dio.get('pokemon/$idOrName');
    return PokemonDetailsDto.fromJson(res.data as Map<String, dynamic>);
  }
}
