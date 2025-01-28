import 'package:bloc/bloc.dart';
import 'package:madrassat_iqraa/core/error/error_message.dart';
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
          ? emit(MeUserLoaded(user))
          : emit(UserError('User not found')),
    );
  }

  // getUserfromFirebase
  Future<void> getUserfromFirebase(String userId) async {
    emit(UserLoading());
    final result = await userRepository.getUserfromFirebase(userId);
    result.fold(
      (error) => emit(UserError(error)),
      (user) => user != null
          ? emit(UserLoaded(user))
          : emit(UserError('User not found')),
    );
  }

  //logout
  Future<void> logOut() async {
    emit(UserLoading());
    final result = await userRepository.logout();
    result.fold(
      (error) => emit(UserError(error)),
      (_) => emit(LogOut()),
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
    final userExists = await isUserExist(user.userName);
    if (userExists) {
      emit(UserError('Username already exists'));
    } else {
      final result = await userRepository.createUser(user);
      result.fold(
        (error) => emit(UserError(error)),
        (_) => emit(
            UserCreated()), // Emit a separate state indicating user creation success
      );
    }
  }

  // fetch user by name
  Future<void> getUserByName(String name) async {
    emit(UserLoading());
    final result = await userRepository.fetchUserByName(name);
    result.fold(
      (error) => emit(UserError(error)),
      (user) =>
          user != null ? emit(UserLoaded(user)) : emit(UserError(itemNotFound)),
    );
  }

  // get the users that are not accepted yet and also not refused so the admin choose either to accept or refuse
  Future<void> getAdminUsers() async {
    emit(UserLoading());

    // Fetch both lists independently
    final result = await userRepository.getUsersNotRefusedOrAccepted();
    final acceptedUsers = await userRepository.getAcceptedUsers();

    result.fold(
      (error) => emit(UserError(error)),
      (users) async {
        acceptedUsers.fold(
          (error) => emit(UserError(error)),
          (accepted) {
            // Emit the state with both lists once both are fetched
            emit(AcceptedUsersLoaded(users, accepted));
          },
        );
      },
    );
  }

  // Check if username exists
  Future<bool> isUserExist(String username) async {
    emit(UserLoading());
    final result = await userRepository.fetchUserByName(username);
    return result.fold(
      (error) {
        return false;
      },
      (user) => user != null,
    );
  }

  //update user

  Future<void> updateUser({required String id, required User user}) async {
    emit(UpdateLoading());

    // Step 1: Update the user
    final result = await userRepository.updateUser(id, user);

    result.fold(
      (error) {
        emit(UserError(error));
      },
      (_) async {
        // Step 2: Fetch both lists simultaneously
        final updatedUsersResult =
            await userRepository.getUsersNotRefusedOrAccepted();
        final acceptedUsersResult = await userRepository.getAcceptedUsers();

        // Step 3: Handle each list independently
        updatedUsersResult.fold(
          (error) {
            emit(UserError(error));
          },
          (updatedUsers) async {
            acceptedUsersResult.fold(
              (error) {
                emit(UserError(error));
              },
              (acceptedUsers) {
                // Step 4: Emit both lists once ready
                emit(AcceptedUsersLoaded(updatedUsers, acceptedUsers));
              },
            );
          },
        );
      },
    );
  }

  // Future<String> getUserId() async {
  //   emit(UserLoading());
  //   final result = await userRepository.getUserId();
  //   return result.fold(
  //     (error) {
  //       emit(UserError(error));
  //       return 'masabahch';
  //     },
  //     (userId) {
  //       if (userId != null) {
  //         emit(IdLoaded(userId));
  //         return userId;
  //       } else {
  //         emit(UserError('User not found'));
  //         return 'null';
  //       }
  //     },
  //   );
  // }
}
