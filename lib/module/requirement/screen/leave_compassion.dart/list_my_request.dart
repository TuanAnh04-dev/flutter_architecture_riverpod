import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:px1_mobile/module/requirement/logic/late_and_early.dart';
import 'package:px1_mobile/module/requirement/logic/leave_compasion.dart';
import 'package:px1_mobile/module/requirement/model/leave_compassion.dart';
import 'package:px1_mobile/module/requirement/screen/late_and_early/add_screen_my_request.dart';

class ListMyRequestLeaveCompassion extends ConsumerStatefulWidget {
  const ListMyRequestLeaveCompassion({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListMyRequestLeaveCompassionState();
}

class _ListMyRequestLeaveCompassionState extends ConsumerState<ListMyRequestLeaveCompassion>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(leaveCompassionProvider);

    List<LeaveCompassion> filterList = [];
    final query = _searchController.text.trim().toLowerCase();

    filterList = query.isEmpty
        ? state.myData
        : state.myData.where((item) => item.toSearchString().toLowerCase().contains(query)).toList();
    Future<bool> delete(String id) async {
      Map<String, dynamic> data = {"id": id, "reason": "Unuse"};
      String jsonString = jsonEncode(data);
      final check = ref.read(lateAndEarlyProvider.notifier).deleteRequest(jsonString);
      return true;
    }

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
                                  ? state.myData
                                  : state.myData
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
                                return AddNewMyRequest(animation: animation);
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
                      List<LeaveCompassion> data = filterList;
                      return data == [] && state.isLoading == true
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (_) async {
                                            final res = await delete(data[index].id);
                                            // if (!context.mounted) {
                                            //   return;
                                            // } // Check liệu widget có bị đóng khi đang xử lý bất đồng bộ hay không
                                            // if (res) {
                                            //   context.pop();
                                            // }
                                          },
                                          backgroundColor: Color.fromRGBO(254, 73, 73, 0.8),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,

                                          label: 'Xóa',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width,
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 2),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 4),
                                                  child: Text(
                                                    '${data[index].employee.lastName} ${data[index].employee.middleName} ${data[index].employee.firstName}',
                                                    style: TextStyle(fontSize: 20, height: 1),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                    color: Colors.grey[100],
                                                    border: Border.all(color: const Color.fromARGB(124, 158, 158, 158)),
                                                  ),

                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                                    child: Text("data[index].category", style: TextStyle(fontSize: 14)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            height: 5,
                                            thickness: 1,
                                            indent: 5,
                                            endIndent: 5,
                                            color: const Color.fromARGB(143, 158, 158, 158),
                                          ),

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Ngày: ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[600],
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    Text(
                                                      "data[index].requiredDate",
                                                      style: TextStyle(fontSize: 15),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(width: 15),
                                                    Text(
                                                      'Giờ: ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[600],
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    Text(
                                                      "data[index].requiredTime",
                                                      style: TextStyle(fontSize: 15),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Lý do:  ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[600],
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.7,
                                                      child: Text("data[index].note", overflow: TextOverflow.ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Ngày tạo yêu cầu:  ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey[600],
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   "DateFormat('yyyy-MM-dd -  kk:mm').format(data[index].createdAt)",
                                                    //   overflow: TextOverflow.ellipsis,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
