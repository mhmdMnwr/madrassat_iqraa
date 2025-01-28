part of 'admin_cubit.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {
  final SchoolState? schoolState;

  const AdminLoaded({required this.schoolState});

  @override
  List<Object> get props => [schoolState ?? ''];
}

final class AdminError extends AdminState {
  final String message;

  const AdminError({required this.message});

  @override
  List<Object> get props => [message];
}

final class AdminUpdated extends AdminState {}
