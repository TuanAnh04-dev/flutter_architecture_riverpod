import 'package:px1_mobile/module/base/model/Employee.dart';

class LeaveCompassion {
  final String id;
  final String startDate;
  final String endDate;
  final String notes;
  final Employee employee;
  final Employee alternativeEmployee;
  final List<LeaveCompassionDetail> dates;

  LeaveCompassion({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.notes,
    required this.dates,
    required this.alternativeEmployee,
    required this.employee,
  });

  factory LeaveCompassion.fromJson(Map<String, dynamic> json) {
    return LeaveCompassion(
      // name: json['name'] ?? '',
      id: json['id'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      notes: json['notes'] ?? '',
      dates: (json['dates'] as List<dynamic>? ?? [])
          .map((e) => LeaveCompassionDetail.fromJson(e))
          .toList(),
      employee: json['employee'] ?? {},
      alternativeEmployee: json['alternative_employee'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate,
      'end_date': endDate,
      'notes': notes,
      'dates': dates.map((e) => e.toJson()).toList(),
    };
  }

  String toSearchString() {
    return '${employee.firstName} ${employee.lastName} ${employee.middleName}  $notes'
        .toLowerCase();
  }
}

class LeaveCompassionDetail {
  final String date;
  final String type; // Fullday, "Half Day - Afternoon", "Half Day - Morning"

  LeaveCompassionDetail({required this.date, required this.type});

  factory LeaveCompassionDetail.fromJson(Map<String, dynamic> json) {
    return LeaveCompassionDetail(
      date: json['date'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'type': type};
  }
}
