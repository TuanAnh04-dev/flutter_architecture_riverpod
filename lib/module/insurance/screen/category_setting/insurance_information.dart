import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance-category/list_screen.dart';
import 'package:px1_mobile/module/insurance/screen/category_setting/insurance_type/list_screen.dart';
import 'package:px1_mobile/route/app_route.dart';

class InsuranceInformation extends ConsumerStatefulWidget {
  const InsuranceInformation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InsuranceInformationState();
}

class _InsuranceInformationState extends ConsumerState<InsuranceInformation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text('Thông tin bảo hiểm'),
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
            height: 40,
            width: 350,
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              // indicatorPadding: EdgeInsetsGeometry.all(5),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              controller: _tabController,
              tabs: [
                Tab(text: 'Danh mục bảo hiểm'),
                Tab(text: 'Loại bảo hiểm'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Center(child: ListInsuranceCategory()),
                Center(child: ListInsuranceType()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
