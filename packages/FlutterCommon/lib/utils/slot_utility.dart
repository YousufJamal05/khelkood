import 'package:intl/intl.dart';

class SlotUtility {
  static final DateFormat _timeFormat = DateFormat('hh:mm a');

  /// Generates a list of time slots (e.g., ["09:00 AM", "10:00 AM"])
  /// based on open and close times.
  static List<String> generateSlots({
    required String openTime,
    required String closeTime,
    int slotDurationMinutes = 60,
  }) {
    List<String> slots = [];
    try {
      DateTime start = _parseTimeString(openTime);
      DateTime end = _parseTimeString(closeTime);

      // Handle cases where close time is on the next day (e.g., 09:00 AM to 02:00 AM)
      if (end.isBefore(start)) {
        end = end.add(const Duration(days: 1));
      }

      DateTime current = start;
      while (current.isBefore(end)) {
        slots.add(_timeFormat.format(current));
        current = current.add(Duration(minutes: slotDurationMinutes));
      }
    } catch (e) {
      // Return empty or default slots if parsing fails
      return [];
    }
    return slots;
  }

  /// Helper to parse time strings like "09:00" or "09:00 AM"
  static DateTime _parseTimeString(String timeStr) {
    try {
      // Try "HH:mm" first
      return DateFormat('HH:mm').parse(timeStr);
    } catch (_) {
      try {
        // Try "hh:mm a"
        return _timeFormat.parse(timeStr);
      } catch (_) {
        rethrow;
      }
    }
  }

  /// Gets the operational hours for a specific week day from the map
  static Map<String, dynamic>? getHoursForDate(
    DateTime date,
    Map<String, dynamic> operationalHours,
  ) {
    final dayKey =
        DateFormat('EEE').format(date).toLowerCase(); // mon, tue, etc.
    if (operationalHours.containsKey(dayKey)) {
      final data = operationalHours[dayKey];
      if (data is Map) {
        return Map<String, dynamic>.from(data);
      }
    }
    return null;
  }

  /// Formats a date for Firestore document ID (YYYY-MM-DD)
  static String formatDateForDoc(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
