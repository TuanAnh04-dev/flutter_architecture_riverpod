import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:px1_mobile/module/insurance/logic/basic_salary.dart';
import 'package:px1_mobile/module/insurance/model/basic_salary.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance-category/add_sreen.dart';
import 'package:string_validator/string_validator.dart';

class ListInsuranceSetting extends ConsumerStatefulWidget {
  const ListInsuranceSetting({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListInsuranceSettingState();
}

class _ListInsuranceSettingState extends ConsumerState<ListInsuranceSetting> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(basicSalaryProvider);

    List<BasicSalary> filterList = [];

    final query = _searchController.text.trim().toLowerCase();

    filterList = query.isEmpty
        ? state.data
        : state.data.where((item) => item.toSearchString().toLowerCase().contains(query)).toList();

    final currencyFormatterVnd = NumberFormat.currency(locale: 'vi_VN', symbol: '\VNĐ');

    return Scaffold(
      backgroundColor: Colors.white,
      body: state.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              filterList = query.isEmpty
                                  ? state.data
                                  : state.data
                                        .where((item) => item.toSearchString().toLowerCase().contains(value))
                                        .toList();
                            });
                          },
                          controller: _searchController,
                          decoration: InputDecoration(
                            hint: Text('Tìm kiếm...'),
                            contentPadding: EdgeInsets.all(10),
                            // Border khi không focus
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: const Color.fromARGB(118, 158, 158, 158), width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            // Border khi focus
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      //Button
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(2, 117, 216, 1)),
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: "Modal",
                              transitionDuration: const Duration(milliseconds: 300),
                              pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                              transitionBuilder: (context, animation, secondaryAnimation, child) {
                                return AddNewInsuranceCategory(animation: animation);
                              },
                            );
                          },
                          child: Text('Thêm mới', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterList.length,
                    itemBuilder: (context, index) {
                      List<BasicSalary> data = filterList;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      final confirmData = data[index].name;
                                      final deleteData = jsonEncode({"id": data[index].id, "reason": "Uesless"});
                                      // print(deleteData);
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Xóa?"),
                                          content: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.7, // hoặc số cố định ví dụ 300
                                            child: Text(
                                              "Bạn có chắc muốn xóa '$confirmData' không?",
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              maxLines: 3,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(backgroundColor: Colors.red[100]),
                                              onPressed: () async {
                                                // if (await ref
                                                //     .read(
                                                //       insuranceCategoryProvider
                                                //           .notifier,
                                                //     )
                                                //     .delete(deleteData)) {
                                                //   Navigator.of(ctx).pop();
                                                // }
                                              },
                                              child: const Text("Xóa"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.go('/insurance-setting');
                                              },
                                              child: const Text("Hủy"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    backgroundColor: Color.fromRGBO(254, 73, 73, 0.8),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,

                                    label: 'Xóa',
                                  ),

                                  // SlidableAction(
                                  //   onPressed: (_) {
                                  //     showGeneralDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       barrierLabel: "Modal",
                                  //       transitionDuration: const Duration(
                                  //         milliseconds: 300,
                                  //       ),
                                  //       pageBuilder: (_, __, ___) =>
                                  //           const SizedBox.shrink(),
                                  //       transitionBuilder:
                                  //           (
                                  //             context,
                                  //             animation,
                                  //             secondaryAnimation,
                                  //             child,
                                  //           ) {
                                  //             return UpdateInsuranceCategory(
                                  //               animation: animation,
                                  //               data: data[index],
                                  //             );
                                  //           },
                                  //     );
                                  //   },
                                  //   backgroundColor: Color.fromRGBO(
                                  //     18,
                                  //     138,
                                  //     0,
                                  //     0.8,
                                  //   ),
                                  //   foregroundColor: Colors.white,
                                  //   icon: Icons.edit,
                                  //   label: 'Sửa',
                                  // ),
                                ],
                              ),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: Offset(2, 6),
                                    ),
                                  ],
                                  border: Border.all(color: const Color.fromARGB(143, 158, 158, 158)),
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 3),
                                          child: Text(data[index].name, style: TextStyle(fontSize: 20)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 0.0),
                                          child: Container(
                                            // color: Colors.redAccent[100],
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  currencyFormatterVnd.format((data[index].minimumSalary).toDouble()),
                                                  style: TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.center,
                                                  textHeightBehavior: TextHeightBehavior(
                                                    applyHeightToFirstAscent: false,
                                                    applyHeightToLastDescent: false,
                                                  ),
                                                ),
                                                Text("  -  "),
                                                Text(
                                                  currencyFormatterVnd.format((data[index].maximumSalary).toDouble()),
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(16.0, 2.0, 8.0, 0.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                data[index].notes ?? '',
                                                style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                              color: Colors.grey[100],
                                              border: Border.all(color: const Color.fromARGB(124, 158, 158, 158)),
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text(data[index].code, style: TextStyle(fontSize: 14)),
                                            ),
                                          ),
                                          // Text(
                                          //   "BHXH",
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.bold,
                                          //     color:
                                          //         data[index].socialInsurance ==
                                          //             "Yes"
                                          //         ? Colors.green
                                          //         : Colors.red,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
