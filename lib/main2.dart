import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/source/student_firebase_service.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/data/source/transaction_firebase.dart';
import 'package:madrassat_iqraa/injection.dart';

void main() async {
  // Create a bunch of students
  for (int i = 0; i < 10; i++) {
    final student = Student(
      name: 'Student $i',
      id: 'student_$i',
      birthDate: '2000-01-01',
      sex: 'Male',
      isTeacher: false,
      payed: true,
      createdAt: DateTime.now(),
    );
    await getIt<StudentRemoteDataSource>().createStudent(student);
  }

  // Create a bunch of teachers
  for (int i = 0; i < 5; i++) {
    final teacher = Student(
      name: 'Teacher $i',
      id: 'teacher_$i',
      birthDate: '1980-01-01',
      sex: 'Female',
      isTeacher: true,
      payed: true,
      createdAt: DateTime.now(),
    );
    await getIt<StudentRemoteDataSource>().createStudent(teacher);
  }

  // Create a bunch of transactions
  for (int i = 0; i < 20; i++) {
    final user = User(
      id: 'user_$i',
      userName: 'User $i',
    );
    final transaction = Transactions(
      type: i % 2 == 0,
      user: user,
      amount: 100 * (i + 1),
      description: 'Transaction $i',
      createdAt: DateTime.now(),
    );
    await getIt<TransactionsRemoteDataSource>().createTransaction(transaction);
  }

  print('Data created successfully ******************************');
}
