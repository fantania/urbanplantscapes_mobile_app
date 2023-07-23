import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:urbanplantscapes_mobile_app/pages/check_out_form.dart';
import 'package:urbanplantscapes_mobile_app/theme/colors.dart';

class AvailabilitiesScreen extends StatefulWidget {
  @override
  _AvailabilitiesScreenState createState() => _AvailabilitiesScreenState();
}

class _AvailabilitiesScreenState extends State<AvailabilitiesScreen> {
  DateTime selectedDate = DateTime.now();
  List<String> timeSlots = [];
  List<Map<String, dynamic>> allData = []; // List to hold all data from Firebase
   // Function to remove the selected slot from Firebase
  Future<void> _removeSlotFromFirebase(String slot) async {
    // First, find the document in Firebase that corresponds to the selected date
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('availabilities')
        .where('date', isEqualTo: DateFormat.yMd().format(selectedDate))
        .get()
        .then((value) => value.docs.first);

    // Update the 'time_slots' array in the document to remove the selected slot
    List<dynamic> timeSlotsData = snapshot.get('time_slots') as List<dynamic>;
    timeSlotsData.remove(slot);

    // Update the document in Firestore
    await snapshot.reference.update({'time_slots': timeSlotsData});
  }

  @override
  void initState() {
    super.initState();
    _fetchAllData(); // Fetch all data from Firebase initially
  }

  Future<void> _fetchAllData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('availabilities').get();

    List<Map<String, dynamic>> data = [];
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic>? documentData = doc.data() as Map<String, dynamic>?;
      if (documentData != null) {
        data.add(documentData);
      }
    });

    setState(() {
      allData = data;
    });
  }

  void _showTimeSlots(DateTime date) {
    List<String> slots = [];
    for (var data in allData) {
      DateTime? documentDate = DateFormat.yMd().parse(data['date'] as String);
      if (documentDate != null && documentDate.isAtSameMomentAs(date)) {
        List<dynamic>? timeSlotsData = data['time_slots'] as List<dynamic>?;
        if (timeSlotsData != null) {
          slots.addAll(timeSlotsData.map((slot) => slot.toString()));
        }
      }
    }
    setState(() {
      timeSlots = slots;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _showTimeSlots(selectedDate); // Show time slots for the selected date
      });
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Book Slot'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://media.istockphoto.com/id/1251347399/vector/hand-with-watch-isolated-on-turquoise-background.jpg?s=612x612&w=0&k=20&c=WJrDIxR-yrdX8r1nbtmgGkWKCud___Q9sLhdRdj7g48='),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 4,
                    lightSource: LightSource.topLeft,
                    color: primary,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        "Select Date",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (timeSlots.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          timeSlots[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        onLongPress: ()async{
                              String removedSlot = timeSlots[index];
                        timeSlots.removeAt(index);
                        await _removeSlotFromFirebase(removedSlot);
                        },
                        onTap: () {
                          Get.arguments['booking_date']=DateFormat('M-dd-yyyy').format(selectedDate);
                          Get.arguments['booking_time']=timeSlots[index];
                          Get.to(PaymentForm(),arguments: Get.arguments,);
                          // Handle time slot selection
                          // You can add your logic here
                        },
                      ),
                    );
                  },
                ),
              )
            else
              Expanded(
                child: Center(
                  child: Text(
                    "No slot Available",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }}
