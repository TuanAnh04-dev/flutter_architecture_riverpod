import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/module/insurance/screen/Insurance_management/setting/list_screen.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance_type/list_screen.dart';
import 'package:px1_mobile/route/app_route.dart';

class SettingInsuranceManagement extends ConsumerStatefulWidget {
  const SettingInsuranceManagement({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettingInsuranceManagementState();
}

class _SettingInsuranceManagementState
    extends ConsumerState<SettingInsuranceManagement>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(routeProvider).pop(); // Quay lại màn hình trước
          },
        ),
        title: Text('Thiết lập bảo hiểm'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Đổ bóng lên trên
                ),
              ],
            ),
            height: 45,
            width: 370,
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              controller: _tabController,
              tabs: [
                Tab(
                  child: SizedBox(
                    width: 80, // hoặc 100, tùy bạn
                    child: Text(
                      'Lương cơ sở',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ), // tùy chỉnh cho nhỏ lại nếu cần
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: 80, // hoặc 100, tùy bạn
                    child: Text(
                      'Lương tối thiểu vùng',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ), // tùy chỉnh cho nhỏ lại nếu cần
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: 80, // hoặc 100, tùy bạn
                    child: Text(
                      'Chính sách bảo hiểm',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ), // tùy chỉnh cho nhỏ lại nếu cần
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: 80, // hoặc 100, tùy bạn
                    child: Text(
                      'Bậc lương',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                      ), // tùy chỉnh cho nhỏ lại nếu cần
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Center(child: ListInsuranceSetting()),
                Center(child: ListInsuranceType()),
                Center(child: ListInsuranceType()),
                Center(child: ListInsuranceType()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
