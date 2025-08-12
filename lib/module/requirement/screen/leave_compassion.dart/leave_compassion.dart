import 'package:flutter/material.dart';
import 'package:px1_mobile/route/app_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/module/requirement/logic/late_and_early.dart';
import 'package:px1_mobile/module/requirement/screen/late_and_early/list_all_request.dart';
import 'package:px1_mobile/module/requirement/screen/late_and_early/list_my_request.dart';
import 'package:px1_mobile/module/requirement/screen/late_and_early/list_orther_request.dart';

class LeaveCompassionManager extends ConsumerStatefulWidget {
  const LeaveCompassionManager({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaveCompassionManagerState();
}

class _LeaveCompassionManagerState extends ConsumerState<LeaveCompassionManager>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final thisIndex = 0;
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
        title: Text('Nghỉ việc riêng'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              setState(() {
                if (_tabController.index == 0) {
                  ref.read(lateAndEarlyProvider.notifier).getList();
                }
              });
            },
          ),
        ],
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
                      'Cá nhân',
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
                      'Nhân viên',
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
                      'Tất cả',
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
                Center(child: ListMyRequest()),
                Center(child: ListOrtherRequest()),
                Center(child: ListAllRequest()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
