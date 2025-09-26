import 'dart:math';
import 'package:dio/dio.dart';
import 'package:pokemon_app/data/dtos/pokemon_details_dto.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final Dio dio;

  PokemonRepositoryImpl(this.dio);

  @override
  Future<Pokemon> getPokemonDetails(String idOrName) async {
    try {
      final response =
          await dio.get('https://pokeapi.co/api/v2/pokemon/$idOrName');
      final dto = PokemonDetailsDto.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      throw Exception('Erro ao carregar detalhes do Pokémon: $e');
    }
  }

  @override
  Future<Pokemon> getRandomPokemon() async {
    try {
      final randomId = Random().nextInt(1025) + 1;
      return getPokemonDetails(randomId.toString());
    } catch (e) {
      throw Exception('Erro ao carregar Pokémon aleatório: $e');
    }
  }
}
