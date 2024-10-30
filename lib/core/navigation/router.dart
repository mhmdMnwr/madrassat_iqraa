import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return const Navigation(); // Navigation widget with bottom bar
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(
            path: '/search', builder: (context, state) => const SearchPage()),
        GoRoute(
            path: '/create', builder: (context, state) => const CreatePage()),
        GoRoute(
            path: '/transactions',
            builder: (context, state) => const TransactionRegisterPage()),
        GoRoute(
            path: '/add_remove_money',
            builder: (context, state) => const AddRemoveMoneyPage()),
      ],
    ),
  ],
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class TransactionRegisterPage extends StatelessWidget {
  const TransactionRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class AddRemoveMoneyPage extends StatelessWidget {
  const AddRemoveMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}
