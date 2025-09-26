import 'package:mobx/mobx.dart';
import 'package:pokemon_app/data/services/poke_api_service.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';

part 'pokemon_details_store.g.dart';

enum PokemonDetailsState { initial, loading, loaded, error }

// ignore: library_private_types_in_public_api
class PokemonDetailsStore = _PokemonDetailsStore with _$PokemonDetailsStore;

abstract class _PokemonDetailsStore with Store {
  final PokeApiService pokeApiService;
  _PokemonDetailsStore(this.pokeApiService);

  @observable
  Pokemon? pokemonDetails;

  @observable
  String? errorMessage;

  @observable
  PokemonDetailsState state = PokemonDetailsState.initial;

  @action
  Future<void> fetchDetails(String idOrName) async {
    state = PokemonDetailsState.loading;
    errorMessage = null;
    pokemonDetails = null;

    try {
      final dto = await pokeApiService.fetchPokemonDetails(idOrName);
      pokemonDetails = dto.toDomain();
      state = PokemonDetailsState.loaded;
    } catch (_) {
      errorMessage = 'Não foi possível carregar detalhes. Tente novamente.';
      state = PokemonDetailsState.error;
    }
  }
}
