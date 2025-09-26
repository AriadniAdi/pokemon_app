import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<Pokemon> getPokemonDetails(String idOrName);
  Future<Pokemon> getRandomPokemon();
}
