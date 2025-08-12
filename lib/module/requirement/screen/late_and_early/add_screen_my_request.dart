import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:px1_mobile/module/base/logic/my_profile.dart';
import 'package:px1_mobile/module/requirement/logic/late_and_early.dart';

class AddNewMyRequest extends ConsumerStatefulWidget {
  const AddNewMyRequest({super.key, required this.animation});
  final Animation<double> animation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewMyRequestState();
}

class _AddNewMyRequestState extends ConsumerState<AddNewMyRequest> {
  String? selectedType;
  DateTime? selectedDate;
  String? selectedStringTime;
  String? selectedStringDate;

  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 00, minute: 00),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    String formatTimeOfDay(TimeOfDay time) {
      final String hour = time.hour.toString().padLeft(2, '0');
      final String minute = time.minute.toString().padLeft(2, '0');
      return "$hour:$minute";
    }

    setState(() {
      selectedStringTime = formatTimeOfDay(pickedTime!);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    setState(() {
      selectedDate = pickedDate;
      selectedStringDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    });
  }

  final List<Map<String, String>> options = [
    {'id': 'early', 'name': 'Về sớm'},
    {'id': 'late', 'name': 'Đi muộn'},
  ];

  @override
  Widget build(BuildContext context) {
    final myId = ref.watch(myProfileProvider).data;

    final hscreen = MediaQuery.of(context).size.height;
    final wscreen = MediaQuery.of(context).size.width;
    final curved = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut,
    );

    Future<bool> submit() async {
      Map<String, dynamic> data = {
        "note": _noteController.text,
        "category": selectedType,
        "required_time": selectedStringTime,
        "required_date": selectedStringDate,
        "sub_employee": [myId!.id],
      };
      String jsonString = jsonEncode(data);
      final check = ref
          .read(lateAndEarlyProvider.notifier)
          .addRequest(jsonString);
      return true;
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(curved),
      child: Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: hscreen * 0.6,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -3), // Đổ bóng lên trên
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Yêu cầu đi trể về sớm',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //all form
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Loại yêu cầu',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  hint: const Text('Chọn một loại'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng chọn một tùy chọn';
                                    }
                                    return null;
                                  },
                                  // Giá trị đang chọn
                                  value: selectedType,

                                  // Gọi khi chọn
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedType = value;
                                    });
                                  },

                                  // Danh sách items (value là id, hiển thị là name)
                                  items: options.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item['id'],
                                      child: Text(
                                        item['name'].toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),

                                  // Tuỳ chỉnh kích thước và style (tuỳ chọn)
                                  buttonStyleData: ButtonStyleData(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    height: 50,
                                    // width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Lý do',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _noteController,
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 16,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  // Viền khi chưa focus
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0,
                                    ),
                                  ),

                                  // Viền khi focus vào
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: wscreen * 0.12,
                                    width: wscreen * 0.6,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                      ),
                                      onPressed: _selectDate,
                                      child: Text(
                                        selectedStringDate ?? "Chọn ngày",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: wscreen * 0.12,
                                    width: wscreen * 0.3,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                      ),
                                      onPressed: _selectTime,
                                      child: Text(
                                        selectedStringTime ?? "Chọn giờ",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
                          width: double.infinity,
                          child: _formKey.currentState?.validate() ?? false
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(
                                      145,
                                      109,
                                      209,
                                      1,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final res = await submit();

                                    if (res == true) {
                                      // ignore: use_build_context_synchronously
                                      context.pop();
                                    }
                                  },
                                  child: Text(
                                    'Thêm mới',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[600],
                                  ),
                                  onPressed: () {
                                    // final res = submit();
                                  },
                                  child: Text(
                                    'Thêm mới',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
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
      ),
    );
  }
}
