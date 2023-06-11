class NewEntryDTO {
  int? quantity;
  String? imageURL;
  DateTime? date;
  double? latitude;
  double? longitude;

  NewEntryDTO(
      {this.quantity, this.imageURL, this.date, this.latitude, this.longitude});
}
