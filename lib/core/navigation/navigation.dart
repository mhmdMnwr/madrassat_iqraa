import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madrassat_iqraa/core/navigation/router.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/create');
        break;
      case 3:
        context.go('/transactions');
        break;
      case 4:
        context.go('/add_remove_money');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getSelectedPage(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.add_box), label: 'Create'),
          NavigationDestination(
              icon: Icon(Icons.receipt_long), label: 'Transactions'),
          NavigationDestination(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Add/Remove Money'),
        ],
      ),
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return const HomePage(); // Replace with your actual Home Page widget
      case 1:
        return const SearchPage(); // Replace with your Search Page widget
      case 2:
        return const CreatePage(); // Replace with your Create Page widget
      case 3:
        return const TransactionRegisterPage(); // Replace with your Transaction Register Page widget
      case 4:
        return const AddRemoveMoneyPage(); // Replace with your Add/Remove Money Page widget
      default:
        return Container(
          color: Colors.grey,
        );
    }
  }
}
