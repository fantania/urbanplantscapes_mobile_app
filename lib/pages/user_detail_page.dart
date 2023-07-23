import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:urbanplantscapes_mobile_app/pages/check_out_form.dart';
import 'package:urbanplantscapes_mobile_app/theme/colors.dart';

import 'calender.dart';


class CustomerDetailScreen extends StatefulWidget {



  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('User Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: -8,
              intensity: 0.8,
              color: Colors.white,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'User Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: -4,
                        intensity: 0.8,
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: -4,
                        intensity: 0.8,
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: -4,
                        intensity: 0.8,
                        color: Colors.white,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        depth: 8,
                        intensity: 0.6,
                        color: primary,
                        shape: NeumorphicShape.flat,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var userdata={
                            'name':_nameController.text,
                            'phone':_phoneController.text,
                            'address':_addressController.text
                          };
                          Get.to(AvailabilitiesScreen(),arguments: userdata);
                          
                        
                        }
                      },
                      child: Text(
                        'Choose Slot',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
