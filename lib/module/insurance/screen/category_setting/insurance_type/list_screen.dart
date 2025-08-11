import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/module/insurance/logic/insurance_type.dart';
import 'package:px1_mobile/module/insurance/model/insurance_type.dart';

class ListInsuranceType extends ConsumerStatefulWidget {
  const ListInsuranceType({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListInsuranceTypeState();
}

class _ListInsuranceTypeState extends ConsumerState<ListInsuranceType> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(insuranceTypeProvider);
    List<InsuranceType> filterList = [];

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
                            // showGeneralDialog(
                            //   context: context,
                            //   barrierDismissible: true,
                            //   barrierLabel: "Modal",
                            //   transitionDuration: const Duration(
                            //     milliseconds: 300,
                            //   ),
                            //   pageBuilder: (_, __, ___) =>
                            //       const SizedBox.shrink(),
                            //   transitionBuilder:
                            //       (
                            //         context,
                            //         animation,
                            //         secondaryAnimation,
                            //         child,
                            //       ) {
                            //         return AddNewInsuranceCategory(
                            //           animation: animation,
                            //         );
                            //       },
                            // );
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
                      List<InsuranceType> data = filterList;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              8.0,
                              6.0,
                              8.0,
                              6.0,
                            ),
                            child: Container(
                              height: 100,
                              // width: MediaQuery.of(context).size.width,
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            16,
                                            16,
                                            16,
                                            0,
                                          ),
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
                                          child: data[index].note == ''
                                              ? Text(
                                                  'Chưa có ghi chú',
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                )
                                              : Text(
                                                  data[index].note,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  maxLines: null,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 13,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
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
                                      children: [
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
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                              data[index].code,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
