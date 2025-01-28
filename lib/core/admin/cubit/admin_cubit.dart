import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/core/admin/model/admin_model.dart';
import 'package:madrassat_iqraa/core/admin/repo/admin_repo.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository adminRepository;

  AdminCubit({required this.adminRepository}) : super(AdminInitial());

  Future<void> getAdminData() async {
    emit(AdminLoading());
    final adminData = await adminRepository.getAdminData();
    adminData.fold(
      (message) => emit(AdminError(message: message)),
      (schoolState) => emit(AdminLoaded(schoolState: schoolState)),
    );
  }

  Future<void> updateAdminData(SchoolState schoolState) async {
    emit(AdminLoading());
    final updateResult = await adminRepository.updateAdminData(schoolState);
    updateResult.fold(
      (message) => emit(AdminError(message: message)),
      (_) => emit(AdminUpdated()),
    );
  }

  // Add one teacher
  Future<void> addTeacher() async {
    await getAdminData();
    if (state is AdminLoaded && (state as AdminLoaded).schoolState != null) {
      final currentState = state as AdminLoaded;
      final updatedState = currentState.schoolState!.copyWith(
        teacherCount: currentState.schoolState!.teacherCount + 1,
      );
      await updateAdminData(updatedState);
    }
  }

  // Remove one teacher
  Future<void> removeTeacher() async {
    await getAdminData();

    if (state is AdminLoaded && (state as AdminLoaded).schoolState != null) {
      final currentState = state as AdminLoaded;
      final updatedState = currentState.schoolState!.copyWith(
        teacherCount: currentState.schoolState!.teacherCount - 1,
      );
      await updateAdminData(updatedState);
    }
  }

  // Add one student
  Future<void> addStudent() async {
    await getAdminData();

    if (state is AdminLoaded && (state as AdminLoaded).schoolState != null) {
      final currentState = state as AdminLoaded;
      final updatedState = currentState.schoolState!.copyWith(
        studentCount: currentState.schoolState!.studentCount + 1,
      );
      await updateAdminData(updatedState);
    }
  }

  // Remove one student
  Future<void> removeStudent() async {
    await getAdminData();
    if (state is AdminLoaded && (state as AdminLoaded).schoolState != null) {
      final currentState = state as AdminLoaded;
      final updatedState = currentState.schoolState!.copyWith(
        studentCount: currentState.schoolState!.studentCount - 1,
      );
      await updateAdminData(updatedState);
    }
  }

  // Add amount to funds
  Future<void> addFunds({required int amount}) async {
    await getAdminData();
    if (state is AdminLoaded && (state as AdminLoaded).schoolState != null) {
      final currentState = state as AdminLoaded;
      final updatedState = currentState.schoolState!.copyWith(
        totalFunds: currentState.schoolState!.totalFunds + amount,
      );
      await updateAdminData(updatedState);
    }
  }

  // Remove amount from funds
  Future<void> removeFunds({required int amount}) async {
    await getAdminData();
    if (state is AdminLoaded && (state as AdminLoaded).schoolState != null) {
      final currentState = state as AdminLoaded;
      final updatedState = currentState.schoolState!.copyWith(
        totalFunds: currentState.schoolState!.totalFunds - amount,
      );
      await updateAdminData(updatedState);
    }
  }
}
