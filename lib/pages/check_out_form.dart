import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:urbanplantscapes_mobile_app/pages/home_page.dart';

import '../theme/colors.dart';

class PaymentForm extends StatefulWidget {
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _removeSlotFromFirebase(String slot) async {
    try {
      print(Get.arguments['booking_date'].toString().replaceAll('-', '/'));

      print(slot);

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('availabilities')
          .where('date',
              isEqualTo:
                  Get.arguments['booking_date'].toString().replaceAll('-', '/'))
          .get()
          .then((value) => value.docs.first);

      List<dynamic> timeSlotsData = snapshot.get('time_slots') as List<dynamic>;
      timeSlotsData.remove(slot);

      await snapshot.reference.update({'time_slots': timeSlotsData});
    } catch (ex) {
      print(ex);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool _isLoading = false;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Payment Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid card number';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _expiryDateController,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid expiry date';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _cvvController,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid CVV';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                _isLoading
                    ? CircularProgressIndicator()
                    : NeumorphicButton(
                        style: NeumorphicStyle(
                          depth: 8,
                          intensity: 0.6,
                          color: primary,
                          shape: NeumorphicShape.flat,
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          'Check Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                SizedBox(height: 20.0),
                Text(_message),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String cardNumber = _cardNumberController.text;
      String expiryDate = _expiryDateController.text;
      String cvv = _cvvController.text;

      _addPaymentDataToFirestore(name, cardNumber, expiryDate, cvv);
    }
  }

  void _addPaymentDataToFirestore(
      String name, String cardNumber, String expiryDate, String cvv) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore.collection('bookings').add({
        'name': name,
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cvv': cvv,
        'timestamp': DateTime.now(),
        'userData': Get.arguments,
      }).whenComplete(() {
        _removeSlotFromFirebase(Get.arguments['booking_time']);
      });

      _nameController.clear();
      _cardNumberController.clear();
      _expiryDateController.clear();
      _cvvController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Get.offAll(Home());
    } catch (error) {
      print('Error uploading data: $error');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading data. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
