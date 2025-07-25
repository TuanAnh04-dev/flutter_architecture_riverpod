import 'package:flutter/material.dart';
import 'package:px1_mobile/module/insurance/screen/modal_of_function/functions_Insurance.dart';

class FunctionPage extends StatelessWidget {
  const FunctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var hscreen = MediaQuery.of(context).size.height;
    var wscreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Container(
          height: 128,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // Bắt đầu từ dưới
              end: Alignment.bottomCenter, // Kết thúc phía trên
              colors: [
                Color.fromRGBO(145, 109, 209, 1), // Màu đậm
                Colors.white, // Màu nhạt hơn
              ],
            ),
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text(
                  'Chức năng',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            //Dòng 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Dashboard tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.dashboard,
                              size: 26,
                              color: Colors.amber,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Dashboard',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Sơ đồ tổ chức tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.map_outlined,
                              size: 26,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sơ đồ tổ chức',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Thiết lập hệ thống tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.power_settings_new,
                              size: 26,
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Thiết lap hệ thống',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Thiết lập danh mục tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.settings_outlined,
                              size: 26,
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Thiết lập danh mục',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            //Dòng 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Thiết lập chính sách tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.policy_outlined,
                              size: 26,
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Thiết lập chính sách',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Hồ sơ nhân sự tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.people_alt_outlined,
                              size: 26,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Hồ sơ nhân sự',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Quản lý dự án tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.list_alt_outlined,
                              size: 26,
                              color: Colors.yellow[600],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Quản lý dự án',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Quản lý ngân sách tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.settings_outlined,
                              size: 26,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Quản lý ngân sách',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            //Dòng 3
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Quản lý yêu cầu tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.lock_clock_outlined,
                              size: 26,
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Quản lý yêu cầu',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Quản lý ngày công tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.bar_chart_outlined,
                              size: 26,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Quản lý ngày công',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Modal",
                        // barrierColor: Colors.black.withOpacity(0.3),
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (_, __, ___) => const SizedBox.shrink(),
                        transitionBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return FunctionsOfInsurance(
                                animation: animation,
                              ); // <-- truyền vào đây
                            },
                      ),
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.health_and_safety_outlined,
                              size: 26,
                              color: Colors.brown[300],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Quản lý bảo hiểm',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Quản lý KPI tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.add_to_photos_outlined,
                              size: 26,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Quản lý KPI',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            //Dòng 4
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 2),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Quản lý lương tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.attach_money_outlined,
                              size: 26,
                              color: Colors.green[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Quản lý lương',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Dữ liệu và biểu mẫu tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.post_add_outlined,
                              size: 26,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Dữ liệu và biểu mẫu',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                SizedBox(
                  height: 110,
                  width: 95,
                  child: InkWell(
                    onTap: () => {print("Gửi thông báo tapped")},
                    child: Container(
                      padding: const EdgeInsets.only(top: 8, left: 1, right: 1),
                      // color: Colors.teal[100],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    117,
                                    158,
                                    158,
                                    158,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Icon(
                              Icons.notifications_none_rounded,
                              size: 26,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Gửi thông báo',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
