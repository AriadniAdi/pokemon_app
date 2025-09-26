import 'package:mobx/mobx.dart';
import 'package:pokemon_app/domain/entities/pokemon_info.dart';
import 'package:pokemon_app/data/services/poke_api_service.dart';

part 'pokemon_list_store.g.dart';

const int kPageSize = 20;

// ignore: library_private_types_in_public_api
class PokemonListStore = _PokemonListStore with _$PokemonListStore;

abstract class _PokemonListStore with Store {
  final PokeApiService pokeApiService;

  _PokemonListStore(this.pokeApiService);

  @observable
  ObservableList<PokemonInfo> pokemonList = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int offset = 0;

  @computed
  bool get canLoadMore => !isLoading;

  @action
  Future<void> refresh() async {
    offset = 0;
    pokemonList.clear();
    await loadMore();
  }

  @action
  Future<void> loadMore() async {
    if (isLoading) return;
    isLoading = true;
    errorMessage = null;
    try {
      final (pokemonDtos, next, _) = await pokeApiService.fetchPokemonPage(
        limit: kPageSize,
        offset: offset,
      );

      final newPokemons = pokemonDtos.map((dto) => dto.toDomain()).toList();

      pokemonList.addAll(newPokemons);

      if (next != null) offset += kPageSize;
    } catch (e) {
      errorMessage = 'Falha ao carregar Pokémon. Verifique sua conexão.';
    } finally {
      isLoading = false;
    }
  }
}
