class Check {
  int id;
  String check;

  Check({required this.id,
    required this.check,
  });

  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(
      id: json['id'],
      check: json['check'],
    );
  }
}