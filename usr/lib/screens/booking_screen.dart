import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/shop.dart';

class BookingScreen extends StatefulWidget {
  final Shop shop;

  const BookingScreen({super.key, required this.shop});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Future<void> _presentTimePicker() async {
    final now = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );
    setState(() {
      _selectedTime = pickedTime;
    });
  }

  void _confirmBooking() {
    if (_selectedDate != null && _selectedTime != null) {
      // Here you would typically handle the booking logic,
      // e.g., save it to a database or notify the shop.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Booking confirmed for ${widget.shop.name} on ${_selectedDate!.toLocal().toString().split(' ')[0]} at ${_selectedTime!.format(context)}'),
        ),
      );
      Navigator.pop(context); // Go back to the detail screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date and time.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment with ${widget.shop.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a date and time for your visit to ${widget.shop.name}.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            // Date Picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text('Choose Date'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Time Picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? 'No time chosen'
                        : 'Time: ${_selectedTime!.format(context)}',
                  ),
                ),
                TextButton(
                  onPressed: _presentTimePicker,
                  child: const Text('Choose Time'),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                ),
                child: const Text('Confirm Booking'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
