import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('vi')) {
    _loadLocale();
  }
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString("language");
    if (code != null) {
      state = Locale(code);
    }
  }

  Future<void> changeLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", locale.languageCode);
    state = locale;
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);
