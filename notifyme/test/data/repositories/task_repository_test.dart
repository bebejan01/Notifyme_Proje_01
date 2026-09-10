import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:notifyme/data/models/priority.dart';
import 'package:notifyme/data/models/task_status.dart';
import 'package:notifyme/data/repositories/goal_repository.dart';
import 'package:notifyme/data/repositories/task_repository.dart';

import '../test_db.dart';

void main() {
  late Database db;
  late TaskRepository taskRepo;
  late GoalRepository goalRepo;

  setUp(() async {
    db = await openTestDatabase();
    taskRepo = TaskRepository(db);
    goalRepo = GoalRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('create without a goal, then getById round-trips it', () async {
    final created = await taskRepo.create(title: 'Bağımsız görev');

    expect(created.goalId, isNull);

    final fetched = await taskRepo.getById(created.id);
    expect(fetched, isNotNull);
    expect(fetched!.goalId, isNull);
    expect(fetched.status, TaskStatus.pending);
  });

  test('create linked to an existing goal, then getByGoalId finds it', () async {
    final goal = await goalRepo.create(title: 'Maraton');
    final created = await taskRepo.create(title: 'Koşuya çık', goalId: goal.id);

    final tasksForGoal = await taskRepo.getByGoalId(goal.id);

    expect(tasksForGoal.map((t) => t.id), contains(created.id));
  });

  test('update persists field changes', () async {
    final created = await taskRepo.create(title: 'Eski', priority: Priority.low);

    await taskRepo.update(created.copyWith(
      title: 'Yeni',
      status: TaskStatus.completed,
      completedAt: DateTime.now(),
    ));

    final fetched = await taskRepo.getById(created.id);
    expect(fetched!.title, 'Yeni');
    expect(fetched.status, TaskStatus.completed);
    expect(fetched.completedAt, isNotNull);
  });

  test('delete removes the task', () async {
    final created = await taskRepo.create(title: 'Silinecek');

    await taskRepo.delete(created.id);

    expect(await taskRepo.getById(created.id), isNull);
  });

  test('deleting the goal sets goal_id to NULL on its tasks, task survives', () async {
    final goal = await goalRepo.create(title: 'Silinecek hedef');
    final task = await taskRepo.create(title: 'Bağlı görev', goalId: goal.id);

    await goalRepo.delete(goal.id);

    final fetched = await taskRepo.getById(task.id);
    expect(fetched, isNotNull, reason: 'task must not be deleted with the goal');
    expect(fetched!.goalId, isNull, reason: 'ON DELETE SET NULL must clear goal_id');
  });

  test('inserting a task with a non-existent goalId is rejected by the FK constraint', () async {
    expect(
      () => taskRepo.create(title: 'Geçersiz FK', goalId: 'does-not-exist'),
      throwsA(isA<DatabaseException>()),
    );
  });
}
