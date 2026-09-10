import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:notifyme/data/models/task_status.dart';
import 'package:notifyme/data/repositories/task_repository.dart';
import 'package:notifyme/services/task_service.dart';

import '../data/test_db.dart';

void main() {
  late Database db;
  late TaskRepository repo;
  late TaskService service;

  setUp(() async {
    db = await openTestDatabase();
    repo = TaskRepository(db);
    service = TaskService.withRepository(repo);
  });

  tearDown(() async {
    await db.close();
  });

  test('empty DB produces an empty pending task list', () async {
    expect(await service.fetchPendingTasks(), isEmpty);
  });

  test('a TaskEntity written directly to SQLite maps to the old Task shape', () async {
    final scheduled = DateTime(2026, 5, 1, 9, 30);
    await repo.create(
      title: 'Repo-yazılan görev',
      description: 'açıklama',
      scheduledAt: scheduled,
    );

    final pending = await service.fetchPendingTasks();

    expect(pending, hasLength(1));
    expect(pending.first.title, 'Repo-yazılan görev');
    expect(pending.first.dueDate, scheduled);
    expect(pending.first.isCompleted, isFalse);
    expect(pending.first.priority, 'medium');
  });

  test('addTask actually writes a row to SQLite with goal_id = null', () async {
    await service.addTask(
      title: 'UI görevi',
      description: 'desc',
      dueDate: DateTime(2026, 6, 1, 8),
      priority: 'high',
    );

    final rows = await repo.getAll();
    expect(rows, hasLength(1));
    expect(rows.first.title, 'UI görevi');
    expect(rows.first.goalId, isNull);
  });

  test('a new TaskService instance over the same repository sees persisted data (reload simulation)', () async {
    await service.addTask(
      title: 'Kalıcı görev',
      description: '',
      dueDate: DateTime(2026, 6, 2),
      priority: 'low',
    );

    final reloadedService = TaskService.withRepository(repo);
    final pending = await reloadedService.fetchPendingTasks();

    expect(pending.map((t) => t.title), contains('Kalıcı görev'));
  });

  test('completing a task sets DB status to completed and stamps completedAt', () async {
    await service.addTask(
      title: 'Tamamlanacak',
      description: '',
      dueDate: DateTime.now(),
      priority: 'medium',
    );
    final created = (await repo.getAll()).single;

    await service.toggleTaskCompletion(created.id);

    final fetched = await repo.getById(created.id);
    expect(fetched!.status, TaskStatus.completed);
    expect(fetched.completedAt, isNotNull);
  });

  test('uncompleting a task sets DB status back to pending and clears completedAt', () async {
    await service.addTask(
      title: 'İleri geri',
      description: '',
      dueDate: DateTime.now(),
      priority: 'medium',
    );
    final created = (await repo.getAll()).single;

    await service.toggleTaskCompletion(created.id);
    await service.toggleTaskCompletion(created.id);

    final fetched = await repo.getById(created.id);
    expect(fetched!.status, TaskStatus.pending);
    expect(fetched.completedAt, isNull);
  });

  test('deleteTask actually removes the row from SQLite', () async {
    await service.addTask(
      title: 'Silinecek',
      description: '',
      dueDate: DateTime.now(),
      priority: 'medium',
    );
    final created = (await repo.getAll()).single;

    await service.deleteTask(created.id);

    expect(await repo.getById(created.id), isNull);
  });
}
