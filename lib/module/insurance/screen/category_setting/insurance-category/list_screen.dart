import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:px1_mobile/module/insurance/logic/insurance_category.dart';
import 'package:px1_mobile/module/insurance/model/insurance_category.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance-category/add_sreen.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance-category/update_screen.dart';

class ListInsuranceCategory extends ConsumerStatefulWidget {
  const ListInsuranceCategory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListInsuranceCategoryState();
}

class _ListInsuranceCategoryState extends ConsumerState<ListInsuranceCategory>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(insuranceCategoryProvider);
    // final type = ref.watch(insuranceTypeProvider).data;
    List<InsuranceCategory> filterList = [];
    final query = _searchController.text.trim().toLowerCase();
    filterList = query.isEmpty
        ? state.data
        : state.data
              .where(
                (item) => item.toSearchString().toLowerCase().contains(query),
              )
              .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       ref.read(routeProvider).pop(); // Quay lại màn hình trước
      //     },
      //   ),
      //   title: Text('Danh mục bảo hiểm'),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add, size: 24.0),
      //       onPressed: () async {
      //         print('add');
      //         await ref.read(insuranceTypeProvider.notifier).getList();
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.shower_rounded, size: 24.0),
      //       onPressed: () async {
      //         for (var item in type) {
      //           print(item.name);
      //         }
      //         // await ref.read(insuranceTypeProvider.notifier).getList();
      //       },
      //     ),
      //   ],
      // ),
      body: state.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
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
                                        .where(
                                          (item) => item
                                              .toSearchString()
                                              .toLowerCase()
                                              .contains(value),
                                        )
                                        .toList();
                            });
                          },
                          controller: _searchController,
                          decoration: InputDecoration(
                            hint: Text('Tìm kiếm...'),
                            contentPadding: EdgeInsets.all(10),
                            // Border khi không focus
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(118, 158, 158, 158),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            // Border khi focus
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                              2,
                              117,
                              216,
                              1,
                            ),
                          ),
                          onPressed: () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: "Modal",
                              transitionDuration: const Duration(
                                milliseconds: 300,
                              ),
                              pageBuilder: (_, __, ___) =>
                                  const SizedBox.shrink(),
                              transitionBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return AddNewInsuranceCategory(
                                      animation: animation,
                                    );
                                  },
                            );
                          },
                          child: Text(
                            'Thêm mới',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterList.length,
                    itemBuilder: (context, index) {
                      List<InsuranceCategory> data = filterList;
                      // _slidableController = SlidableController(this);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              8.0,
                              6.0,
                              8.0,
                              6.0,
                            ),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      final confirmData = data[index].name;
                                      final deleteData = jsonEncode({
                                        "id": data[index].id,
                                        "reason": "Uesless",
                                      });
                                      // print(deleteData);
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Xóa?"),
                                          content: SizedBox(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.7, // hoặc số cố định ví dụ 300
                                            child: Text(
                                              "Bạn có chắc muốn xóa '$confirmData' không?",
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              maxLines: 3,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    Colors.red[100],
                                              ),
                                              onPressed: () async {
                                                if (await ref
                                                    .read(
                                                      insuranceCategoryProvider
                                                          .notifier,
                                                    )
                                                    .delete(deleteData)) {
                                                  Navigator.of(ctx).pop();
                                                }
                                              },
                                              child: const Text("Xóa"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.go(
                                                  '/insurance-information',
                                                );
                                              },
                                              child: const Text("Hủy"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    backgroundColor: Color.fromRGBO(
                                      254,
                                      73,
                                      73,
                                      0.8,
                                    ),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,

                                    label: 'Xóa',
                                  ),
                                  SlidableAction(
                                    onPressed: (_) {
                                      showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel: "Modal",
                                        transitionDuration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        pageBuilder: (_, __, ___) =>
                                            const SizedBox.shrink(),
                                        transitionBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child,
                                            ) {
                                              return UpdateInsuranceCategory(
                                                animation: animation,
                                                data: data[index],
                                              );
                                            },
                                      );
                                    },
                                    backgroundColor: Color.fromRGBO(
                                      18,
                                      138,
                                      0,
                                      0.8,
                                    ),
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Sửa',
                                  ),
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
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      143,
                                      158,
                                      158,
                                      158,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            data[index].name,
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            16.0,
                                            0.0,
                                            8.0,
                                            0.0,
                                          ),
                                          child:
                                              data[index].insuranceType.name ==
                                                  ''
                                              ? Text(
                                                  data[index]
                                                      .insuranceType
                                                      .name,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                )
                                              : Text(
                                                  data[index]
                                                      .insuranceType
                                                      .name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        8.0,
                                        10.0,
                                        8.0,
                                        8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              color: Colors.grey[100],
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                  124,
                                                  158,
                                                  158,
                                                  158,
                                                ),
                                              ),
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                6.0,
                                              ),
                                              child: Text(
                                                data[index].code,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "BHXH",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  data[index].socialInsurance ==
                                                      "Yes"
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
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
