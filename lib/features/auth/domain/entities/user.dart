import 'package:equatable/equatable.dart';

class SayuUser extends Equatable {
  final String id;
  final String email;
  final String? name;
  final DateTime createdAt;
  final DateTime? lastSeenAt;
  final Map<String, dynamic>? metadata;

  const SayuUser({
    required this.id,
    required this.email,
    this.name,
    required this.createdAt,
    this.lastSeenAt,
    this.metadata,
  });

  @override
  List<Object?> get props => [id, email, name, createdAt, lastSeenAt, metadata];

  SayuUser copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
    DateTime? lastSeenAt,
    Map<String, dynamic>? metadata,
  }) {
    return SayuUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      metadata: metadata ?? this.metadata,
    );
  }
}