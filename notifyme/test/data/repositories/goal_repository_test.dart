import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:notifyme/data/models/goal_status.dart';
import 'package:notifyme/data/models/priority.dart';
import 'package:notifyme/data/repositories/goal_repository.dart';

import '../test_db.dart';

void main() {
  late Database db;
  late GoalRepository repo;

  setUp(() async {
    db = await openTestDatabase();
    repo = GoalRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('create then getById returns the same goal', () async {
    final created = await repo.create(title: '10km koşmak', priority: Priority.high);

    final fetched = await repo.getById(created.id);

    expect(fetched, isNotNull);
    expect(fetched!.title, '10km koşmak');
    expect(fetched.priority, Priority.high);
    expect(fetched.status, GoalStatus.active);
  });

  test('getAll returns every created goal', () async {
    await repo.create(title: 'A');
    await repo.create(title: 'B');

    final all = await repo.getAll();

    expect(all.map((g) => g.title), containsAll(['A', 'B']));
    expect(all, hasLength(2));
  });

  test('update persists field changes and bumps updatedAt', () async {
    final created = await repo.create(title: 'Eski başlık');
    final beforeUpdate = created.updatedAt;

    await Future<void>.delayed(const Duration(milliseconds: 5));
    await repo.update(created.copyWith(title: 'Yeni başlık', status: GoalStatus.completed));

    final fetched = await repo.getById(created.id);
    expect(fetched!.title, 'Yeni başlık');
    expect(fetched.status, GoalStatus.completed);
    expect(fetched.updatedAt.isAfter(beforeUpdate), isTrue);
  });

  test('delete removes the goal', () async {
    final created = await repo.create(title: 'Silinecek');

    await repo.delete(created.id);

    expect(await repo.getById(created.id), isNull);
  });
}
