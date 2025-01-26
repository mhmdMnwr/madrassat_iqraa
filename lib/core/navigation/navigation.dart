import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void navigateToPage(BuildContext context, String pageName) {
  switch (pageName) {
    case 'main':
      context.push('/Main');
    case 'home':
      context.push('/home');
      break;
    case 'searchTeatcher':
      context.push('/searchTeatcher');
      break;
    case 'searchStudent':
      context.push('/searchStudent');
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
    case 'admin':
      context.push('/admin');
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
  'admin',
  'main'
];
