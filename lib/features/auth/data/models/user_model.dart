import '../../domain/entities/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class UserModel extends SayuUser {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
    required super.createdAt,
    super.lastSeenAt,
    super.metadata,
  });

  factory UserModel.fromSupabaseUser(supabase.User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String?,
      createdAt: DateTime.parse(user.createdAt),
      lastSeenAt: user.lastSignInAt != null 
          ? DateTime.parse(user.lastSignInAt!) 
          : null,
      metadata: user.userMetadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'last_seen_at': lastSeenAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastSeenAt: json['last_seen_at'] != null 
          ? DateTime.parse(json['last_seen_at'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
}