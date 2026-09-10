import 'package:flutter_test/flutter_test.dart';

import 'package:notifyme/data/models/goal_status.dart';
import 'package:notifyme/data/models/priority.dart';
import 'package:notifyme/data/models/task_status.dart';

void main() {
  test('Priority round-trips through toDb/fromDb', () {
    for (final p in Priority.values) {
      expect(Priority.fromDb(p.toDb()), p);
    }
  });

  test('Priority.fromDb throws on an unknown/corrupt value', () {
    expect(() => Priority.fromDb('urgent'), throwsFormatException);
  });

  test('GoalStatus round-trips through toDb/fromDb', () {
    for (final s in GoalStatus.values) {
      expect(GoalStatus.fromDb(s.toDb()), s);
    }
  });

  test('GoalStatus.fromDb throws on an unknown/corrupt value', () {
    expect(() => GoalStatus.fromDb('paused'), throwsFormatException);
  });

  test('TaskStatus round-trips through toDb/fromDb', () {
    for (final s in TaskStatus.values) {
      expect(TaskStatus.fromDb(s.toDb()), s);
    }
  });

  test('TaskStatus.fromDb throws on an unknown/corrupt value', () {
    expect(() => TaskStatus.fromDb('skipped'), throwsFormatException);
  });
}
