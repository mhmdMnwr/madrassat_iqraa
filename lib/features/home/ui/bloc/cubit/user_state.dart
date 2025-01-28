part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class LogOut extends UserState {}

class UserLoading extends UserState {}

class UpdateLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}

class UsersLoaded extends UserState {
  final List<User> users;

  UsersLoaded(this.users);
}

class AcceptedUsersLoaded extends UserState {
  final List<User> updatedUsers; // List for users not refused or accepted
  final List<User> acceptedUsers; // List for accepted users

  AcceptedUsersLoaded(this.updatedUsers, this.acceptedUsers);
}

// class IdLoaded extends UserState {
//   final String userId;

//   IdLoaded(this.userId);
// }

class UserSaved extends UserState {} // State when user ID is successfully saved

class UserUpdated
    extends UserState {} // State when user is successfully updated

class UserCreated
    extends UserState {} // State when a new user is successfully created

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
