import 'package:firebase_database/firebase_database.dart';

import '../../../auth/domain/repositories/auth_repository.dart';
import '../models/task_model.dart';

/// Abstract class defining the contract for Task remote data operations.
///
/// This interface specifies all the methods that a remote data source
/// implementation must provide to interact with task data stored remotely.
abstract class TaskRemoteDataSource {
  /// Retrieves all tasks for the current user.
  Future<List<TaskModel>> getAllTasks();

  /// Creates a new task with the given parameters.
  Future<void> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
  });

  /// Updates an existing task with the given parameters.
  Future<void> updateTask({
    required String id,
    required String title,
    required String description,
    required DateTime dueDate,
    required bool isCompleted,
  });

  /// Deletes a task with the given ID.
  Future<void> deleteTask({required String id});
}

/// Implementation of [TaskRemoteDataSource] using Firebase Realtime Database.
///
/// This class provides concrete implementation of all remote data operations
/// for tasks, using Firebase as the backend service.
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseDatabase _db;
  final AuthRepository _authRepository;

  TaskRemoteDataSourceImpl({
    required FirebaseDatabase db,
    required AuthRepository authRepository,
  }) : _db = db,
       _authRepository = authRepository;

  /// Gets the reference to the current user's tasks in Firebase.
  DatabaseReference get _userTasksRef {
    final user = _authRepository.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return _db.ref('users/${user.uid}/tasks');
  }

  @override
  Future<void> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
  }) async {
    try {
      final newTaskRef = _userTasksRef.push();
      await newTaskRef.set(
        TaskModel(
          id: newTaskRef.key,
          title: title,
          description: description,
          dueDate: dueDate,
          isCompleted: false,
        ).toJson(),
      );
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  @override
  Future<void> deleteTask({required String id}) async {
    try {
      await _userTasksRef.child(id).remove();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final snapshot = await _userTasksRef.get();
      if (!snapshot.exists) return [];

      final data = snapshot.value as Map<dynamic, dynamic>;
      return data.entries
          .map(
            (entry) => TaskModel.fromJson({
              'id': entry.key,
              ...Map<String, dynamic>.from(entry.value),
            }),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get tasks: $e');
    }
  }

  @override
  Future<void> updateTask({
    required String id,
    required String title,
    required String description,
    required DateTime dueDate,
    required bool isCompleted,
  }) async {
    try {
      await _userTasksRef.child(id).update({
        'title': title,
        'description': description,
        'dueDate': dueDate.millisecondsSinceEpoch,
        'isCompleted': isCompleted,
      });
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }
}
