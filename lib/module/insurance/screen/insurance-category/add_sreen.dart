import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:px1_mobile/module/insurance/logic/insurance_category.dart';
import 'package:px1_mobile/module/insurance/logic/insurance_type.dart';

class AddNewInsuranceCategory extends ConsumerStatefulWidget {
  const AddNewInsuranceCategory({super.key, required this.animation});
  final Animation<double> animation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewInsuranceCategoryState();
}

class _AddNewInsuranceCategoryState
    extends ConsumerState<AddNewInsuranceCategory> {
  bool _isSelected = true;
  String? selectedType;

  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hscreen = MediaQuery.of(context).size.height;
    final wscreen = MediaQuery.of(context).size.width;
    final curved = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeOut,
    );
    final insuranceType = ref.watch(insuranceTypeProvider).data;
    late bool res = false;
    Future<bool> _submit() async {
      Map<String, dynamic> data = {
        "name": _nameController.text,
        "code": _codeController.text,
        "notes": _noteController.text,
        "social_insurance": _isSelected ? "Yes" : "No",
        "insurance_type": selectedType,
      };
      String jsonString = jsonEncode(data);
      // print("From UI: $jsonString");
      return await ref
          .read(insuranceCategoryProvider.notifier)
          .addNew(jsonString);
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
            height: hscreen * 0.8,
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
                      'Thêm mới danh mục',
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
                                'Tên danh mục',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 5,
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
                                  // Viền khi validate
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Mã danh mục',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _codeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Không được để trống';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 5,
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
                                  // Viền khi validate
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Loại bảo hiểm',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  hint: const Text('Chọn một mục'),
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
                                  items: insuranceType.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id,
                                      child: Text(
                                        item.name,
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
                              Row(
                                children: [
                                  Text('BHXH:'),
                                  SizedBox(width: 12),
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: _isSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            _isSelected = value!;
                                            print(_isSelected);
                                          });
                                        },
                                      ),
                                      Text('Có'),
                                    ],
                                  ),
                                  SizedBox(width: 24),
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: false,
                                        groupValue: _isSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            _isSelected = value!;
                                            print(_isSelected);
                                          });
                                        },
                                      ),
                                      Text('Không'),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Ghi chú',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              TextFormField(
                                controller: _noteController,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Không được để trống';
                                //   }
                                //   return null;
                                // },
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
                                    res = await _submit();
                                    if (res) {
                                      // ignore: use_build_context_synchronously
                                      context.go('/list-insurance-category');
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
                                  onPressed: () {},
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
