import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:px1_mobile/route/app_route.dart';

void myToast({
  required String title,
  String? description,
  ToastificationType type = ToastificationType.info,
  Alignment? alignment = Alignment.topRight,
}) {
  final context = rootNavigatorKey.currentContext;
  if (context == null) return;

  toastification.show(
    context: context,
    title: Text(title),
    description: description != null ? Text(description) : null,
    type: type,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 3),
    alignment: alignment,
    showProgressBar: true,
  );
}
