/// Singleton local user profile row (id is always [UserProfile.localId]).
class UserProfile {
  static const String localId = 'local';

  final String id;
  final String? primaryPurpose;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    this.id = localId,
    this.primaryPurpose,
    required this.createdAt,
    required this.updatedAt,
  });

  UserProfile copyWith({
    String? primaryPurpose,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id,
      primaryPurpose: primaryPurpose ?? this.primaryPurpose,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserProfile.fromRow(Map<String, Object?> row) {
    return UserProfile(
      id: row['id'] as String,
      primaryPurpose: row['primary_purpose'] as String?,
      createdAt: DateTime.parse(row['created_at'] as String),
      updatedAt: DateTime.parse(row['updated_at'] as String),
    );
  }

  Map<String, Object?> toRow() {
    return {
      'id': id,
      'primary_purpose': primaryPurpose,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
