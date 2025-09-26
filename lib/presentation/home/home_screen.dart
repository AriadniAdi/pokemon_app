import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_app/core/constants.dart';
import 'package:pokemon_app/domain/entities/pokemon_info.dart';
import 'package:pokemon_app/presentation/details/pokemon_details_screen.dart';
import 'package:pokemon_app/presentation/pokemon_list/pokemon_list_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/services/poke_api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PokemonListStore pokemonListStore;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pokemonListStore = PokemonListStore(PokeApiService());
    pokemonListStore.refresh();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 300 &&
        pokemonListStore.canLoadMore) {
      pokemonListStore.loadMore();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() => pokemonListStore.refresh();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.pokeDex)),
      body: Observer(
        builder: (_) {
          if (pokemonListStore.pokemonList.isEmpty &&
              pokemonListStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (pokemonListStore.pokemonList.isEmpty &&
              pokemonListStore.errorMessage != null) {
            return _ErrorRetry(
              message: pokemonListStore.errorMessage!,
              onRetry: pokemonListStore.refresh,
            );
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              controller: scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: pokemonListStore.pokemonList.length +
                  (pokemonListStore.isLoading ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                if (index >= pokemonListStore.pokemonList.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final pokemon = pokemonListStore.pokemonList[index];
                return _PokemonTile(
                  pokemon: pokemon,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PokemonDetailsScreen(
                          idOrName: pokemon.id.toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _PokemonTile extends StatelessWidget {
  final PokemonInfo pokemon;
  final VoidCallback onTap;

  const _PokemonTile({required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: pokemon.thumbSprite,
        width: 56,
        height: 56,
        placeholder: (_, __) => const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
      ),
      title: Text('#${pokemon.id}  ${pokemon.name.toUpperCase()}'),
      subtitle: Text(AppLocalizations.of(context)!.tapForDetails),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _ErrorRetry({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)!.retry),
          ),
        ],
      ),
    );
  }
}
