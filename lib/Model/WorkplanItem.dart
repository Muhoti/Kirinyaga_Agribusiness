// ignore_for_file: non_constant_identifier_names

class WorkplanItem {
  final String Duration;
  final String Description;
  final String Task;
  final String Subcounty;
  final String Ward;
  final String Date;
  final double Latitude;
  final double Longitude;
  const WorkplanItem(this.Duration, this.Description, this.Task, this.Subcounty,
      this.Ward, this.Date, this.Latitude, this.Longitude);
}
