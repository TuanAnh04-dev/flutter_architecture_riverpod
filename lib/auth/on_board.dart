import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo + illustration
              Column(
                children: [
                  const SizedBox(height: 20),
                  // Logo Trello (tạm thay bằng Icon)
                  const Icon(Icons.dashboard, size: 64, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    "Trolle",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 32),
                  // Illustration placeholder
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.blue.shade50,
                    child: const Center(child: Text("Illustration")),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Đưa tinh thần đồng đội tiến về phía trước - ngay cả khi đang di chuyển",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),

              // Buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Đã bấm Đăng nhập");
                        context.go('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 👈 bo góc
                        ),
                      ),
                      child: const Text("Đăng nhập", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        print("Đã bấm Đăng ký");
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 👈 bo góc
                        ),
                      ),
                      child: const Text("Đăng ký", style: TextStyle(fontSize: 16, color: Colors.blue)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Khi đăng ký, bạn đồng ý với Điều khoản bảo người dùng và Chính sách quyền riêng tư.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Bạn không đăng nhập hoặc đăng ký được...",
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
