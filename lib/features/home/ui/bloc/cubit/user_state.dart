part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);
}

class UserSaved extends UserState {} // State when user ID is successfully saved

class UserCreated
    extends UserState {} // State when a new user is successfully created

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
