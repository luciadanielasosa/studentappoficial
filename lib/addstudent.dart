import 'package:flutter/material.dart';
import 'package:studentappoficial/studentlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class Addstudent extends StatefulWidget {
  Addstudent();

  @override
  _AddstudentState createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  _AddstudentState();

  final _addFormKey = GlobalKey<FormState>();
  final _studentIDController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  final _enrollmentDateController = TextEditingController();

  Future<Job> createCase(Job job) async {
    print(job);
    Map data = {
      'StudentID': job.studentID,
      'LastName': job.lastName,
      'FirstName': job.firsName,
      'EnrollmentDate': /*DateTime.parse(json['EnrollmentDate']),*/
          DateFormat('yyyy-MM-dd HH:mm:ss').format(job.enrollmentDate)
    };
    /*print(data);*/
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final jobsListAPIUrl =
        'https://appservicelucia.azurewebsites.net/api/students';
    final response = await http.post(
      jobsListAPIUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return Job.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cases'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('StudentID'),
                              TextFormField(
                                controller: _studentIDController,
                                decoration: const InputDecoration(
                                  hintText: 'StudentID',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter full StudentID';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('LastName'),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  hintText: 'LastName',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter full LastName';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('FirstName'),
                              TextFormField(
                                controller: _firstNameController,
                                decoration: const InputDecoration(
                                  hintText: 'FirstName',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter full FirstName';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('EnrollmentDate'),
                              TextFormField(
                                controller: _enrollmentDateController,
                                decoration: const InputDecoration(
                                  hintText: 'EnrollmentDate',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter EnrollmentDate';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState.validate()) {
                                    _addFormKey.currentState.save();
                                    createCase(Job(
                                        studentID: int.parse(
                                            _studentIDController.text),
                                        lastName: _lastNameController.text,
                                        firsName: _firstNameController.text,
                                        enrollmentDate: DateTime.parse(
                                            _enrollmentDateController.text)));

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.indigo[600],
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
