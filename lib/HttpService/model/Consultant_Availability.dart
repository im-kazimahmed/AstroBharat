
class ConsultantAvailability {
  bool success;
  Map<String, Map<String, Map<String, String>>>? appointments;

  ConsultantAvailability({required this.success, this.appointments});

  factory ConsultantAvailability.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['data'];
    if(data['appointments'].isEmpty) {
      return ConsultantAvailability(
        success: json['success'],
        appointments: {},
      );
    } else {

      final Map<String, dynamic> appointmentsJson = data['appointments'];
      print(appointmentsJson);
      final Map<String, Map<String, Map<String, String>>> appointments = {};
      for (final sessionType in appointmentsJson.keys) {
        final Map<String, dynamic> daysJson = appointmentsJson[sessionType];
        final Map<String, Map<String, String>> sessionDays = {};
        for (final day in daysJson.keys) {
          final Map<String, String> daySlots = {};
          for (final startTime in daysJson[day].keys) {
            daySlots[startTime] = daysJson[day][startTime];
          }
          sessionDays[day] = daySlots;
        }
        appointments[sessionType] = sessionDays;
      }
      return ConsultantAvailability(
        success: json['success'],
        appointments: appointments,
      );
    }
  }
}