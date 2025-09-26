class Pokemon {
  final int id;
  final String name;
  final double height;
  final double weight;
  final List<String> types;
  final List<String> abilities;
  final String artwork;

  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.artwork,
  });
}
