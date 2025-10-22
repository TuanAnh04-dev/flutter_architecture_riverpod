import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/feature/user/presentation/page/product_detail_page.dart';
import 'package:px1_mobile/feature/user/presentation/providers/user_provider.dart';
import 'package:px1_mobile/feature/user/presentation/widgets/user_card.dart';

class EmployeesListPage extends ConsumerWidget {
  const EmployeesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesState = ref.watch(employeesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(employeesNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: employeesState.when(
        // Loading state
        loading: () => const Center(child: CircularProgressIndicator()),

        // Error state
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(
                'Error: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(employeesNotifierProvider.notifier).refresh();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),

        // Data state
        data: (employees) {
          if (employees.isEmpty) {
            return const Center(child: Text('No employees found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(employeesNotifierProvider.notifier).refresh();
            },
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return EmployeeCard(
                  employee: employee,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeByIdPage(
                          employeeId: employee.id.toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
