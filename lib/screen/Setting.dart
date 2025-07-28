import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:px1_mobile/auth/auth_provider.dart';
import 'package:px1_mobile/module/insurance/logic/insurance_category.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Setting extends ConsumerStatefulWidget {
  const Setting({super.key});

  @override
  ConsumerState<Setting> createState() => _SettingState();
}

class _SettingState extends ConsumerState<Setting> {
  void printUserAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final localUser = prefs.getString('userAuth');
    if (localUser != null) {
      dynamic user = jsonDecode(localUser) as Map<String, dynamic>;
    } else {
      print("Error parse");
    }
  }

  @override
  Widget build(BuildContext context) {
    final listen = ref.watch(insuranceCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Setting ', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Settings Page',
              style: TextStyle(fontSize: 24, color: Colors.deepPurple),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: () async {
              // context.go('/login');
              print('Logout');
              printUserAuth();
              ref.read(authProvider.notifier).logout();
            },
            child: Text('Logout'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(insuranceCategoryProvider.notifier).getList();
            },
            child: Text('Get List'),
          ),
          ElevatedButton(
            onPressed: () async {
              print(">>>>>>>>Check listen: " + listen.data.toString());
            },
            child: Text('listen'),
          ),
        ],
      ),
    );
  }
}
