class UserEntity {
  final String id;
  final String email;
  final String name;
  final String? token;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.token,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ name.hashCode;
}
