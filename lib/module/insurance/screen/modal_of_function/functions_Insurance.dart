import 'package:flutter/material.dart';

class FunctionsOfInsurance extends StatelessWidget {
  const FunctionsOfInsurance({super.key, required this.animation});
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    var hscreen = MediaQuery.of(context).size.height;
    // var wscreen = MediaQuery.of(context).size.width;
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
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
            height: hscreen / 4,
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Quản lý bảo hiểm',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 110,
                        width: 95,
                        child: InkWell(
                          onTap: () => {print("Thiết lập")},
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 1,
                              right: 1,
                            ),
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
                                    Icons.settings_applications_outlined,
                                    size: 26,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Thiết lập',
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
                          onTap: () => {print("Quản lý")},
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 1,
                              right: 1,
                            ),
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
                                    Icons.category_outlined,
                                    size: 26,
                                    color: Colors.blue[600],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Quản lý',
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
                          onTap: () => {print("Báo cáo")},
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 1,
                              right: 1,
                            ),
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
                                    Icons.text_snippet_outlined,
                                    size: 26,
                                    color: Colors.orange[600],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Báo cáo',
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
                          onTap: () => {print("Theo dõi nộp bảo hiểm")},
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 1,
                              right: 1,
                            ),
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
                                    Icons.remove_red_eye_outlined,
                                    size: 26,
                                    color: Colors.blue[900],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Theo dõi nộp bảo hiểm',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
