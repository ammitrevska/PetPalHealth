class Pet {
  final String name;
  final String profileImage;
  final String species;
  final String breed;
  final String gender;
  final String age;
  final double weight;

  Pet(
      {required this.name,
      this.profileImage = '',
      required this.species,
      required this.breed,
      required this.gender,
      required this.age,
      required this.weight});
}
