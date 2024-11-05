import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/core/admin/admin_state.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/user_model.dart';

class Transactions extends Equatable {
  final User user;
  final bool type; // true for income, false for expense
  final int amount; // amount of the transaction
  final String description; // description of the transaction
  final DateTime createdAt; // timestamp of when the transaction was created

  Transactions({
    required this.type,
    required this.user,
    required this.amount,
    required this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now() {
    AdminStatsService().incrementTransactionCount();
    if (type) {
      AdminStatsService().adjustFunds(amount as double);
    } else {
      AdminStatsService().adjustExpenses(amount as double);
    }
  }

  @override
  List<Object?> get props => [type, amount, description, createdAt];

  // Factory constructor to create a Transaction instance from JSON
  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      type: json['type'] as bool,
      amount: json['amount'] as int,
      description: json['description'] as String,
      user: json['user'] as User,
      // Parse createdAt from String to DateTime
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Method to convert a Transaction instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'description': description,
      'user': user,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
