import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:px1_mobile/module/requirement/logic/late_and_early.dart';
import 'package:px1_mobile/module/requirement/model/late_and_early.dart';

class ListOrtherRequest extends ConsumerStatefulWidget {
  const ListOrtherRequest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListOrtherRequestState();
}

class _ListOrtherRequestState extends ConsumerState<ListOrtherRequest>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lateAndEarlyProvider);

    List<LateAndEarly> filterList = [];
    final query = _searchController.text.trim().toLowerCase();

    filterList = query.isEmpty
        ? state.ortherData
        : state.ortherData
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
                                  ? state.ortherData
                                  : state.ortherData
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
                          onPressed: () {},
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
                      List<LateAndEarly> data = filterList;
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
                                    onPressed: (_) {},
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
                                          padding: const EdgeInsets.fromLTRB(
                                            16,
                                            10,
                                            16,
                                            3,
                                          ),
                                          child: Text(
                                            data[index].employee.isEmpty
                                                ? ''
                                                : '${data[index].employee[0].lastName} ${data[index].employee[0].middleName} ${data[index].employee[0].firstName}',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            16.0,
                                            0.0,
                                            8.0,
                                            0.0,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${data[index].requiredTime} - ${data[index].requiredDate}',
                                                style: TextStyle(fontSize: 15),
                                                textAlign: TextAlign.center,
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false,
                                                      applyHeightToLastDescent:
                                                          false,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            16.0,
                                            2.0,
                                            8.0,
                                            0.0,
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.7,
                                                child: Text(
                                                  data[index].note,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
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
                                                data[index].category,
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
