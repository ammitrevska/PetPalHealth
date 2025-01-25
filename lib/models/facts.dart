class Facts {
  final String fact;
  final String pet;

  Facts({
    required this.fact,
    required this.pet,
  });

  factory Facts.fromJsonCat(String fact) {
    return Facts(
      fact: fact,
      pet: 'cat',
    );
  }

  factory Facts.fromJsonDog(Map<String, dynamic> json) {
    final body = json['attributes']['body'];

    return Facts(
      fact: body,
      pet: 'dog',
    );
  }

  factory Facts.fromJson(Map<String, dynamic> json, String petType) {
    return Facts(
      fact: json['fact'],
      pet: petType,
    );
  }
}
