import 'package:doctor_appointment/chat.dart';
import 'package:doctor_appointment/doctor_registration.dart';
import 'package:doctor_appointment/hospita_register.dart';
import 'package:doctor_appointment/patient_registration_form.dart';
import 'package:doctor_appointment/referre.dart';
import 'package:doctor_appointment/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static final id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print('user email" ${loggedInUser.email}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                child: Text("Logo"),
                backgroundColor: Color(0xFFffe97d),
                radius: 5.0,
              ),
              decoration: BoxDecoration(color: Color(0xFFFFB74D)),
            ),
            ListTile(
              title: Text('Notification'),
              leading: Icon(
                Icons.notifications,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text('share'),
              leading: Icon(Icons.share),
              onTap: () {},
            ),
            ListTile(
              title: Text('contact'),
              leading: Icon(Icons.contact_phone),
              onTap: () {},
            ),
            ListTile(
              title: Text('Public Policy'),
              leading: Icon(Icons.security),
              onTap: () {},
            ),
            ListTile(
              title: Text('Chat with Doctor'),
              leading: Icon(Icons.chat),
              onTap: () => Navigator.pushNamed(context, ChatScreen.id),
            ),
            ListTile(
                title: Text('Sign Out'),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  _auth.signOut();
                  Navigator.pushReplacementNamed(context, LoginScreen.id);
                })
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text("Register",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600)),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(HospitalRegister.id);
            },
            color: Color(0xFFFFE97D),
            child: Text("Hospital"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DoctorRegister.id);
            },
            color: Color(0xFFFFE97D),
            child: Text("Doctor"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(PatientRegistrationForm.patient_form);
            },
            color: Color(0xFFFFE97D),
            child: Text("Patient"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Referee.id);
            },
            color: Color(0xFFFFE97D),
            child: Text("Referred Person"),
          ),
        ],
      )),
    );
  }
}
