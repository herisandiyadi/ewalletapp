class UpdateRequest {
  UpdateRequest({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  factory UpdateRequest.fromJson(Map<String, dynamic> json) => UpdateRequest(
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
      };
}
