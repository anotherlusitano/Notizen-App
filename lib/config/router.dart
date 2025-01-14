import 'package:go_router/go_router.dart';
import 'package:notizen/activities/home_activity.dart';
import 'package:notizen/activities/login_activity.dart';
import 'package:notizen/activities/sign_up_activity.dart';

enum Routes {
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
      builder: (context, state) => const SignUpActivity(),
    ),
    GoRoute(
      name: Routes.home.name,
      path: '/home',
      builder: (context, state) => const HomeActivity(),
    ),
  ],
);
