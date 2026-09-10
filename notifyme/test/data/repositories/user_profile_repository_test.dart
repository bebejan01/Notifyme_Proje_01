import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:notifyme/data/models/user_profile.dart';
import 'package:notifyme/data/repositories/user_profile_repository.dart';

import '../test_db.dart';

void main() {
  late Database db;
  late UserProfileRepository repo;

  setUp(() async {
    db = await openTestDatabase();
    repo = UserProfileRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('get returns null before any write', () async {
    expect(await repo.get(), isNull);
  });

  test('upsert creates the row on first call', () async {
    final created = await repo.upsert(primaryPurpose: 'egitim');

    expect(created.id, UserProfile.localId);
    expect(created.primaryPurpose, 'egitim');

    final fetched = await repo.get();
    expect(fetched, isNotNull);
    expect(fetched!.primaryPurpose, 'egitim');
  });

  test('upsert on an existing row updates it instead of inserting a second row', () async {
    await repo.upsert(primaryPurpose: 'egitim');
    await repo.upsert(primaryPurpose: 'is');

    final fetched = await repo.get();
    expect(fetched!.primaryPurpose, 'is');

    final raw = await db.query('user_profile');
    expect(raw, hasLength(1));
  });
}
