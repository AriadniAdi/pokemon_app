import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_app/presentation/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'splash_store.dart';

class SplashScreen extends StatefulWidget {
  final SplashStore store;

  const SplashScreen({super.key, required this.store});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _revealAnimation;

  SplashStore get store => widget.store;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _revealAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _init();
  }

  Future<void> _init() async {
    await store.loadRandomPokemon();

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) _controller.forward();

    await Future.delayed(const Duration(seconds: 5));
    if (mounted && store.errorMessage == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Observer(
          builder: (_) {
            if (store.isLoading) {
              return const CircularProgressIndicator();
            }

            if (store.errorMessage != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.loadingError,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      _controller.reset();
                      _init();
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              );
            }

            if (store.pokemon == null) {
              return Text(AppLocalizations.of(context)!.noPokemonAvailable);
            }

            final pokemon = store.pokemon!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.splashTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                ),
                const SizedBox(height: 30),
                AnimatedBuilder(
                  animation: _revealAnimation,
                  builder: (_, __) {
                    return ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(1 - _revealAnimation.value),
                        BlendMode.srcATop,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: pokemon.artwork,
                        width: 220,
                        height: 220,
                        fit: BoxFit.contain,
                        placeholder: (_, __) =>
                            const CircularProgressIndicator(),
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 64),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: _revealAnimation,
                  child: Text(
                    pokemon.name.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
