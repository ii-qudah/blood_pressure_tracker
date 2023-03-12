class ChartModel {
  final String date;
  final int systolic;
  final int pulse;
  final String time;
  final int diastolic;
  final int id;

  ChartModel(
      {required this.pulse,
      required this.time,
      required this.date,
      required this.id,
      required this.systolic,
      required this.diastolic});
}
