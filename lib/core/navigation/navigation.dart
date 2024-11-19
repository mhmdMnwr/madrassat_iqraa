import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void navigateToPage(BuildContext context, String pageName) {
  switch (pageName) {
    case 'home':
      context.push('/home');
      break;
    case 'studentsList':
      context.push('/studentsList');
      break;
    case 'teachersList':
      context.push('/teachersList');
      break;
    case 'expenses':
      context.push('/expenses');
      break;
    case 'income':
      context.push('/income');
      break;
    case 'transaction':
      context.push('/transaction');
      break;
    default:
      context.push('/');
  }
}

const List<String> pageNames = [
  'studentsList',
  'teachersList',
  'expenses',
  'income',
  'transaction',
];
