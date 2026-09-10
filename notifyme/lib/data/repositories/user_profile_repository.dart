import 'package:sqflite/sqflite.dart';

import '../models/user_profile.dart';

/// CRUD access to the single `user_profile` row.
///
/// There is exactly one profile (id = [UserProfile.localId]), so no UUID is
/// generated here — using a fixed id is the simplest option consistent with
/// the "singleton local profile, no real auth" decision in the FAZ 1 audit.
class UserProfileRepository {
  UserProfileRepository(this._db);

  final Database _db;

  Future<UserProfile?> get() async {
    final rows = await _db.query(
      'user_profile',
      where: 'id = ?',
      whereArgs: [UserProfile.localId],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UserProfile.fromRow(rows.first);
  }

  /// Creates the profile if it does not exist yet, otherwise updates
  /// [primaryPurpose] and bumps `updated_at`.
  Future<UserProfile> upsert({String? primaryPurpose}) async {
    final existing = await get();
    final now = DateTime.now();

    if (existing == null) {
      final created = UserProfile(
        primaryPurpose: primaryPurpose,
        createdAt: now,
        updatedAt: now,
      );
      await _db.insert('user_profile', created.toRow());
      return created;
    }

    final updated = existing.copyWith(
      primaryPurpose: primaryPurpose,
      updatedAt: now,
    );
    await _db.update(
      'user_profile',
      updated.toRow(),
      where: 'id = ?',
      whereArgs: [UserProfile.localId],
    );
    return updated;
  }
}
