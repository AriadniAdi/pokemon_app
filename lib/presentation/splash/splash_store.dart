import 'package:mobx/mobx.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/usecases/get_random_pokemon.dart';

part 'splash_store.g.dart';

// ignore: library_private_types_in_public_api
class SplashStore = _SplashStore with _$SplashStore;

abstract class _SplashStore with Store {
  final GetRandomPokemon getRandomPokemon;

  _SplashStore(this.getRandomPokemon);

  @observable
  Pokemon? pokemon;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadRandomPokemon() async {
    isLoading = true;
    errorMessage = null;

    try {
      pokemon = await getRandomPokemon();
    } catch (e) {
      pokemon = null;
      errorMessage = "Falha ao carregar o Pokémon";
    } finally {
      isLoading = false;
    }
  }
}
