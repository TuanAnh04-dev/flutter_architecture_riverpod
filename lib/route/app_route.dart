import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/auth/login_screen.dart';
import 'package:px1_mobile/auth/on_board.dart';
import 'package:px1_mobile/feature/product/presentation/pages/product_list_page.dart';
import 'package:px1_mobile/module/insurance/screen/Insurance_management/setting_insurance_management.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance-category/list_screen.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance_information.dart';
import 'package:px1_mobile/module/requirement/screen/late_and_early/late_and_early.dart';
import 'package:px1_mobile/module/user/screen/list_user.dart';
import 'package:px1_mobile/screen/Dashboard.dart';
import 'package:px1_mobile/screen/Function.dart';
import 'package:px1_mobile/screen/Homepage.dart';
import 'package:px1_mobile/screen/Setting.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final routeProvider = Provider<GoRouter>((ref) {
  // final locale = ref.watch(localeProvider);
  final auth = ref.watch(authProvider);

  if (auth.isLoggedIn) {
    Fluttertoast.showToast(
      msg: "Đăng nhập thành công",
      toastLength: Toast.LENGTH_LONG, // hoặc Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // vị trí: TOP, CENTER, BOTTOM
      backgroundColor: Colors.green[100],
      textColor: Colors.green,
      fontSize: 16.0,
    );
  }
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoading = auth.isLoading;
      if (isLoading) return null;
      final currentPath = state.matchedLocation;

      final loggedIn = (auth.userAuth != null);
      final loggingIn = state.matchedLocation == '/login';
      // Danh sách route công khai (không cần login)
      final publicRoutes = ['/login', '/on-boarding'];
      final isPublicRoute = publicRoutes.contains(currentPath);

      if (!loggedIn && !isPublicRoute) return '/on-boarding';

      if (loggedIn && isPublicRoute) return '/home';

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
      GoRoute(
        path: '/on-boarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/list-insurance-category',
        builder: (context, state) => const ListInsuranceCategory(),
      ),
      GoRoute(
        path: '/insurance-information',
        builder: (context, state) => const InsuranceInformation(),
      ),
      GoRoute(
        path: '/insurance-setting',
        builder: (context, state) => const SettingInsuranceManagement(),
      ),
      GoRoute(
        path: '/late-and-early',
        builder: (context, state) => const LateAndEarlyManager(),
      ),
      GoRoute(
        path: "/product-list-page",
        builder: (context, state) => const ProductListPage(),
      ),
    ],
  );
});
