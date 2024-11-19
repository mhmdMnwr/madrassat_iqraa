import 'package:bloc/bloc.dart';
import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(UserInitial());

  // Get user by ID
  Future<void> getUserById() async {
    emit(UserLoading());
    final result = await userRepository.getUserById();
    result.fold(
      (error) => emit(UserError(error)),
      (user) => user != null
          ? emit(UserLoaded(user))
          : emit(UserError('User not found')),
    );
  }

  // Save user ID
  Future<void> saveUserId(String userId) async {
    emit(UserLoading());
    final result = await userRepository.saveUserId(userId);
    result.fold(
      (error) => emit(UserError(error)),
      (_) => emit(UserSaved()), // Emit a separate state indicating success
    );
  }

  // Create user
  Future<void> createUser(User user) async {
    emit(UserLoading());
    final result = await userRepository.createUser(user);
    result.fold(
      (error) => emit(UserError(error)),
      (_) => emit(
          UserCreated()), // Emit a separate state indicating user creation success
    );
  }
}
