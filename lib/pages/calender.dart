import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAvailabilities extends StatefulWidget {
  const AdminAvailabilities({super.key});

  @override
  State<AdminAvailabilities> createState() => _AdminAvailabilitiesState();
}

class _AdminAvailabilitiesState extends State<AdminAvailabilities> {
  CollectionReference Adminavailabilities =
      FirebaseFirestore.instance.collection('availabilities');

 
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> stream = Adminavailabilities.snapshots();
    var size = MediaQuery.of(context).size;
    return Scaffold(
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;
                        return Card(
                          elevation: 4,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            title: Text(
                              data['date'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['time'],
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Icon(Icons.timelapse_sharp),
                            onTap: () {
                              // add your onTap logic here
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )

      
          ],
        ),
      ),
    );
  }
}
