import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/new_entry_dto.dart';

void main() {
  test('model gives expected values', () {
    final date = DateTime.parse('2020-02-20');
    const url = 'tester';
    const quantity = 5;
    const latitude = 2.5;
    const longitude = 2.5;

    final newEntryDto = NewEntryDTO(
        date: DateTime.parse('2020-02-20'),
        imageURL: 'tester',
        quantity: 5,
        latitude: 2.5,
        longitude: 2.5);

    expect(newEntryDto.date, date);
    expect(newEntryDto.imageURL, url);
    expect(newEntryDto.quantity, quantity);
    expect(newEntryDto.latitude, latitude);
    expect(newEntryDto.longitude, longitude);
  });
}
