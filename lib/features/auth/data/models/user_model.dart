import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

/// A data model representing user information, extending [UserEntity].
///
/// This class serves as a data layer representation of user information,
/// providing conversion methods to/from Firebase's [User] objects and
/// the domain-level [UserEntity].
class UserModel extends UserEntity {
  /// Creates a [UserModel] with the given parameters.
  ///
  /// All parameters are passed to the parent [UserEntity] class.
  const UserModel({required super.id, super.email, super.name});

  /// Unauthorizate
  static const empty = UserModel(id: '');

  /// Creates a [UserModel] instance from a Firebase [User] object.
  factory UserModel.fromFirebaseUser(User user) =>
      UserModel(id: user.uid, email: user.email, name: user.displayName);
}
