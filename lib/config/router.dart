import 'package:go_router/go_router.dart';
import 'package:notizen/activities/home_activity.dart';
import 'package:notizen/activities/login_activity.dart';
import 'package:notizen/activities/sign_up_activity.dart';
import 'package:notizen/activities/todo_activity.dart';
import 'package:notizen/data/user_repository.dart';

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
      redirect: (context, state) {
        return UsersRepository.instance.anyoneLoggedIn().then((user) {
          return user == null ? '/login' : '/home/${user.username}';
        });
      },
    ),
    GoRoute(
      name: Routes.signUp.name,
      path: '/sign-up',
      builder: (context, state) => SignUpActivity(),
    ),
    GoRoute(
      name: Routes.home.name,
      path: '/home/:username',
      builder: (context, state) => HomeActivity(
        username: state.pathParameters['username'],
      ),
    ),
    GoRoute(
      name: Routes.todo.name,
      path: '/todo/:todoId/:todoOwner',
      builder: (context, state) => TodoActivity(
        todoId: state.pathParameters['todoId'],
        todoOwner: state.pathParameters['todoOwner'],
      ),
    ),
  ],
);
