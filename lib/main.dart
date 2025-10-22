import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/core/language/language_logic.dart';
import 'package:px1_mobile/core/util/local_store.dart';
import 'package:px1_mobile/route/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      fallbackLocale: const Locale('vi'),
      path: 'assets/lang',
      child: ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    final route = ref.watch(routeProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
        title: 'Px1',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'MyriadPro',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: route,
        locale: context.locale,
        supportedLocales: const [Locale('vi'), Locale('en')],
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }
}
