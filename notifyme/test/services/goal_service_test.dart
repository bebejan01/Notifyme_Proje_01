import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:notifyme/data/models/goal_status.dart';
import 'package:notifyme/data/models/priority.dart';
import 'package:notifyme/data/repositories/goal_repository.dart';
import 'package:notifyme/data/repositories/task_repository.dart';
import 'package:notifyme/services/goal_service.dart';

import '../data/test_db.dart';

void main() {
  late Database db;
  late GoalRepository goalRepo;
  late TaskRepository taskRepo;
  late GoalService service;

  setUp(() async {
    db = await openTestDatabase();
    goalRepo = GoalRepository(db);
    taskRepo = TaskRepository(db);
    service = GoalService.withRepository(goalRepo);
  });

  tearDown(() async {
    await db.close();
  });

  test('empty DB produces an empty goal list', () async {
    expect(await service.getAllGoals(), isEmpty);
  });

  test('createGoal actually writes a row to SQLite', () async {
    await service.createGoal(title: 'Maraton', priority: Priority.high);

    final rows = await goalRepo.getAll();
    expect(rows, hasLength(1));
    expect(rows.first.title, 'Maraton');
    expect(rows.first.priority, Priority.high);
  });

  test('a created goal can be read back by id', () async {
    final created = await service.createGoal(title: '10km koşmak');

    final fetched = await service.getGoalById(created.id);

    expect(fetched, isNotNull);
    expect(fetched!.title, '10km koşmak');
  });

  test('getActiveGoals filters out completed and abandoned goals', () async {
    final active = await service.createGoal(title: 'Aktif hedef');
    final completed = await service.createGoal(title: 'Tamamlanmış hedef');
    await service.updateGoal(completed.copyWith(status: GoalStatus.completed));
    final abandoned = await service.createGoal(title: 'Vazgeçilen hedef');
    await service.updateGoal(abandoned.copyWith(status: GoalStatus.abandoned));

    final activeGoals = await service.getActiveGoals();

    expect(activeGoals.map((g) => g.id), [active.id]);
  });

  test('getCompletedGoals returns only completed goals', () async {
    final active = await service.createGoal(title: 'Aktif hedef');
    final completed = await service.createGoal(title: 'Tamamlanmış hedef');
    await service.updateGoal(completed.copyWith(status: GoalStatus.completed));
    expect(active.status, GoalStatus.active);

    final completedGoals = await service.getCompletedGoals();

    expect(completedGoals.map((g) => g.id), [completed.id]);
  });

  test('updateGoal persists field changes to SQLite', () async {
    final created = await service.createGoal(title: 'Eski başlık');

    await service.updateGoal(created.copyWith(title: 'Yeni başlık'));

    final fetched = await goalRepo.getById(created.id);
    expect(fetched!.title, 'Yeni başlık');
  });

  test('deleteGoal removes the row from SQLite', () async {
    final created = await service.createGoal(title: 'Silinecek');

    await service.deleteGoal(created.id);

    expect(await goalRepo.getById(created.id), isNull);
  });

  test('createGoal rejects an empty title', () async {
    expect(
      () => service.createGoal(title: ''),
      throwsArgumentError,
    );
  });

  test('createGoal rejects a whitespace-only title', () async {
    expect(
      () => service.createGoal(title: '   '),
      throwsArgumentError,
    );
  });

  test('deleting a goal does not delete its tasks, and clears their goalId', () async {
    final goal = await service.createGoal(title: 'Silinecek hedef');
    final task = await taskRepo.create(title: 'Bağlı görev', goalId: goal.id);

    await service.deleteGoal(goal.id);

    final fetchedTask = await taskRepo.getById(task.id);
    expect(fetchedTask, isNotNull, reason: 'task must survive goal deletion');
    expect(fetchedTask!.goalId, isNull, reason: 'ON DELETE SET NULL must clear goal_id');
  });
}
