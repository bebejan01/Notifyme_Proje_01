import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/goal.dart';
import '../models/task.dart';
import '../services/goal_service.dart';
import '../services/task_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];
  bool _isLoading = true;

  List<Goal> _activeGoals = [];
  bool _isLoadingGoals = true;
  String? _goalsError;

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadActiveGoals();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final tasks = await taskService.fetchPendingTasks();
      if (!mounted) return;
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gorevler yuklenemedi: ${error.toString()}')),
      );
    }
  }

  Future<void> _loadActiveGoals() async {
    setState(() {
      _isLoadingGoals = true;
      _goalsError = null;
    });

    try {
      final goals = await goalService.getActiveGoals();
      if (!mounted) return;
      setState(() {
        _activeGoals = goals;
        _isLoadingGoals = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoadingGoals = false;
        _goalsError = error.toString();
      });
    }
  }

  Future<void> _refreshAll() async {
    await Future.wait([_loadTasks(), _loadActiveGoals()]);
  }

  void _showCreateGoalDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    DateTime? selectedDeadline;
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Yeni Hedef Ekle'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Hedef Basligi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Aciklama (opsiyonel)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        labelText: 'Kategori (opsiyonel)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: const Text('Bitis Tarihi (opsiyonel)'),
                      subtitle: Text(
                        selectedDeadline != null
                            ? DateFormat('dd/MM/yyyy').format(selectedDeadline!)
                            : 'Secilmedi',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDeadline ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedDeadline = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSubmitting
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: const Text('Iptal'),
                ),
                ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : () async {
                          final title = titleController.text.trim();
                          if (title.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Lutfen hedef basligi girin')),
                            );
                            return;
                          }

                          setDialogState(() {
                            isSubmitting = true;
                          });

                          final description =
                              descriptionController.text.trim();
                          final category = categoryController.text.trim();

                          try {
                            await goalService.createGoal(
                              title: title,
                              description:
                                  description.isEmpty ? null : description,
                              category: category.isEmpty ? null : category,
                              deadline: selectedDeadline,
                            );

                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Hedef eklendi')),
                            );
                            _loadActiveGoals();
                          } catch (error) {
                            if (!context.mounted) return;
                            setDialogState(() {
                              isSubmitting = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Hata: ${error.toString()}')),
                            );
                          }
                        },
                  child: isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Ekle'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedPriority = 'medium';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Yeni Gorev Ekle'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Gorev Basligi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Aciklama',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: const Text('Tarih'),
                      subtitle:
                          Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: const Text('Saat'),
                      subtitle: Text(selectedTime.format(context)),
                      trailing: const Icon(Icons.access_time),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: selectedPriority,
                      decoration: const InputDecoration(
                        labelText: 'Oncelik',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'low', child: Text('Dusuk')),
                        DropdownMenuItem(value: 'medium', child: Text('Orta')),
                        DropdownMenuItem(value: 'high', child: Text('Yuksek')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedPriority = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Iptal'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Lutfen gorev basligi girin')),
                      );
                      return;
                    }

                    final dueDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );

                    try {
                      await taskService.addTask(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        dueDate: dueDateTime,
                        priority: selectedPriority,
                      );

                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Gorev eklendi')),
                      );
                      _loadTasks();
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hata: ${error.toString()}')),
                      );
                    }
                  },
                  child: const Text('Ekle'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _toggleTaskCompletion(Task task) async {
    try {
      await taskService.toggleTaskCompletion(task.id);
      _loadTasks();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: ${error.toString()}')),
        );
      }
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getPriorityText(String priority) {
    switch (priority) {
      case 'high':
        return 'Yuksek';
      case 'medium':
        return 'Orta';
      case 'low':
        return 'Dusuk';
      default:
        return 'Bilinmiyor';
    }
  }

  Widget _buildActiveGoalsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aktif Hedefler',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _showCreateGoalDialog,
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Hedef ekle',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_isLoadingGoals)
            const SizedBox(
              height: 96,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_goalsError != null)
            const Text(
              'Hedefler yuklenemedi',
              style: TextStyle(color: Colors.red),
            )
          else if (_activeGoals.isEmpty)
            const Text(
              'Henüz aktif bir hedefin yok.',
              style: TextStyle(color: Colors.grey),
            )
          else
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _activeGoals.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) =>
                    _buildGoalCard(_activeGoals[index]),
              ),
            ),
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildGoalCard(Goal goal) {
    final hasCategory = goal.category != null && goal.category!.trim().isNotEmpty;

    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            goal.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (hasCategory) ...[
            const SizedBox(height: 4),
            Text(
              goal.category!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ],
          if (goal.deadline != null) ...[
            const SizedBox(height: 4),
            Text(
              DateFormat('dd/MM/yyyy').format(goal.deadline!),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          _buildActiveGoalsSection(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _tasks.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.task_outlined,
                                size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Henuz gorev yok',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Yeni gorev eklemek icin + butonuna basin',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshAll,
                        child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      final isOverdue = task.dueDate.isBefore(DateTime.now());

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (_) => _toggleTaskCompletion(task),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (task.description.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(task.description),
                              ],
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: isOverdue ? Colors.red : Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat('dd/MM/yyyy HH:mm')
                                        .format(task.dueDate),
                                    style: TextStyle(
                                      color:
                                          isOverdue ? Colors.red : Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(task.priority)
                                          .withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _getPriorityText(task.priority),
                                      style: TextStyle(
                                        color: _getPriorityColor(task.priority),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
