import 'package:go_router/go_router.dart';
import 'package:notizen/activities/home_activity.dart';
import 'package:notizen/activities/login_activity.dart';
import 'package:notizen/activities/sign_up_activity.dart';
import 'package:notizen/activities/todo_activity.dart';

enum Routes {
  todo,
  home,
  login,
  signUp,
}

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: Routes.login.name,
      path: '/login',
      builder: (context, state) => LoginActivity(),
    ),
    GoRoute(
      name: Routes.signUp.name,
      path: '/sign-up',
      builder: (context, state) => SignUpActivity(),
    ),
    GoRoute(
      name: Routes.home.name,
      path: '/home',
      builder: (context, state) => const HomeActivity(),
    ),
    GoRoute(
      name: Routes.todo.name,
      path: '/todo',
      builder: (context, state) => TodoActivity(),
    ),
  ],
);
