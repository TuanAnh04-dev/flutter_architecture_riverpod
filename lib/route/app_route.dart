import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/auth/login_screen.dart';
import 'package:px1_mobile/module/user/screen/list_user.dart';
import 'package:px1_mobile/screen/Dashboard.dart';
import 'package:px1_mobile/screen/Function.dart';
import 'package:px1_mobile/screen/Homepage.dart';
import 'package:px1_mobile/screen/Setting.dart';

final routeProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final loggedIn = auth.userAuth != null;
      final loggingIn = state.matchedLocation == '/login';
      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/Homepage';
      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: '/home', builder: (context, state) => Homepage()),
      GoRoute(
        path: '/Dashboard',
        builder: (context, state) => const Dashboard(),
      ),
      GoRoute(path: '/User', builder: (context, state) => const ListUser()),
      GoRoute(path: '/Work', builder: (context, state) => const FunctionPage()),
      GoRoute(path: '/Setting', builder: (context, state) => const Setting()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ],
  );
});
