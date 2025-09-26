import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemon_app/data/services/poke_api_service.dart';
import 'package:pokemon_app/presentation/details/pokemon_details_store.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final String idOrName;
  const PokemonDetailsScreen({super.key, required this.idOrName});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late final PokemonDetailsStore pokemonDetailsStore;

  @override
  void initState() {
    super.initState();
    pokemonDetailsStore = PokemonDetailsStore(PokeApiService());
    pokemonDetailsStore.fetchDetails(widget.idOrName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes: ${widget.idOrName.toUpperCase()}'),
      ),
      body: Observer(
        builder: (_) {
          switch (pokemonDetailsStore.state) {
            case PokemonDetailsState.loading:
              return const Center(child: CircularProgressIndicator());

            case PokemonDetailsState.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pokemonDetailsStore.errorMessage ?? '',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () =>
                          pokemonDetailsStore.fetchDetails(widget.idOrName),
                      icon: const Icon(Icons.refresh),
                      label: Text(AppLocalizations.of(context)!.retry),
                    ),
                  ],
                ),
              );

            case PokemonDetailsState.initial:
              return Center(
                child: Text(AppLocalizations.of(context)!.noDetailsLoaded),
              );

            case PokemonDetailsState.loaded:
              final selectedPokemon = pokemonDetailsStore.pokemonDetails!;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: selectedPokemon.artwork,
                        width: 220,
                        height: 220,
                        fit: BoxFit.contain,
                        placeholder: (_, __) => const SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 64),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${selectedPokemon.name.toUpperCase()}  #${selectedPokemon.id}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _InfoChip(
                          label: AppLocalizations.of(context)!.types,
                          value: selectedPokemon.types.join(', '),
                        ),
                        _InfoChip(
                          label: AppLocalizations.of(context)!.height,
                          value:
                              '${selectedPokemon.height.toStringAsFixed(1)} m',
                        ),
                        _InfoChip(
                          label: AppLocalizations.of(context)!.weight,
                          value:
                              '${selectedPokemon.weight.toStringAsFixed(1)} kg',
                        ),
                        _InfoChip(
                          label: AppLocalizations.of(context)!.abilities,
                          value: selectedPokemon.abilities.join(', '),
                        ),
                      ],
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
