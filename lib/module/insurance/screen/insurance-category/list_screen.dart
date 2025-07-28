import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:px1_mobile/module/insurance/logic/insurance_category.dart';
import 'package:px1_mobile/module/insurance/model/insurance_category.dart';
import 'package:px1_mobile/route/app_route.dart';

class ListInsuranceCategory extends ConsumerStatefulWidget {
  const ListInsuranceCategory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListInsuranceCategoryState();
}

class _ListInsuranceCategoryState extends ConsumerState<ListInsuranceCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () => ref.read(insuranceCategoryProvider.notifier).getList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listData = ref.watch(insuranceCategoryProvider);
    print(listData.data);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(routeProvider).pop(); // Quay lại màn hình trước
          },
        ),
        title: Text('Dánh mục bảo hiểm'),
      ),

      body: listData.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listData.data.length,
              itemBuilder: (context, index) {
                // if (listData.data.isEmpty) {

                //   return Text('Chưa có dữ liệu');
                // }
                List<InsuranceCategory> data = listData.data;
                return Column(
                  children: [ListTile(title: Text(data[index].name))],
                );
              },
            ),
    );
  }
}
