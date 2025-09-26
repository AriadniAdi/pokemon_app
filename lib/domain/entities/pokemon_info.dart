class PokemonInfo {
  final String name;
  final String url;

  const PokemonInfo({
    required this.name,
    required this.url,
  });

  int get id {
    final parts = url.split('/');
    return int.parse(parts.where((p) => p.isNotEmpty).last);
  }

  String get thumbSprite =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  String get artwork =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}
