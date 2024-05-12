import 'package:flutter/material.dart';
import 'firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widget_tree.dart';
import 'login.dart';
import 'package:firebase_database/firebase_database.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class StructUserInfo {
  int TotalBinsAdded;
  int TotalBinsLiked;
  int TotalBinsDisliked;
  int BlackBinsAdded;
  int BlackBinsLiked;
  int BlackBinsDisliked;
  int GreenBinsAdded;
  int GreenBinsLiked;
  int GreenBinsDisliked;
  int YellowBinsAdded;
  int YellowBinsLiked;
  int YellowBinsDisliked;
  int BlueBinsAdded;
  int BlueBinsLiked;
  int BlueBinsDisliked;

  StructUserInfo(this.TotalBinsAdded, this.TotalBinsLiked, this.TotalBinsDisliked, this.BlackBinsAdded, this.BlackBinsLiked, this.BlackBinsDisliked, this.GreenBinsAdded, this.GreenBinsLiked, this.GreenBinsDisliked, this.YellowBinsAdded, this.YellowBinsLiked, this.YellowBinsDisliked, this.BlueBinsAdded, this.BlueBinsLiked, this.BlueBinsDisliked);
}

class _ProfileState extends State<Profile> {
  final database = FirebaseDatabase.instance.ref();
  String user_email = FirebaseAuth.instance.currentUser!.email!;

  StructUserInfo userInfo = StructUserInfo(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);

  Future<void> resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: user_email);
  }

  @override
  Widget build(BuildContext context) {
    final user_profile_information_ref = database.child('/users_info/${FirebaseAuth.instance.currentUser!.uid}');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future: user_profile_information_ref.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("No user found in database.", textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            // final data = Map<String, dynamic>.from((snapshot.data! as Event).snapshot.value);
            final data = snapshot.data!.value as Map<dynamic, dynamic>;
            int black_bins_added = data['black_bins']!['added']! as int;
            int black_bins_liked = data['black_bins']!['liked']! as int;
            int black_bins_disliked = data['black_bins']!['disliked']! as int;
            int green_bins_added = data['green_bins']!['added']! as int;
            int green_bins_liked = data['green_bins']!['liked']! as int;
            int green_bins_disliked = data['green_bins']!['disliked']! as int;
            int yellow_bins_added = data['yellow_bins']!['added']! as int;
            int yellow_bins_liked = data['yellow_bins']!['liked']! as int;
            int yellow_bins_disliked = data['yellow_bins']!['disliked']! as int;
            int blue_bins_added = data['blue_bins']!['added']! as int;
            int blue_bins_liked = data['blue_bins']!['liked']! as int;
            int blue_bins_disliked = data['blue_bins']!['disliked']! as int;
            int total_bins_added = black_bins_added + green_bins_added + yellow_bins_added + blue_bins_added;
            int total_bins_liked = black_bins_liked + green_bins_liked + yellow_bins_liked + blue_bins_liked;
            int total_bins_disliked = black_bins_disliked + green_bins_disliked + yellow_bins_disliked + blue_bins_disliked;
            userInfo = StructUserInfo(
              total_bins_added,
              total_bins_liked,
              total_bins_disliked,
              black_bins_added,
              black_bins_liked,
              black_bins_disliked,
              green_bins_added,
              green_bins_liked,
              green_bins_disliked,
              yellow_bins_added,
              yellow_bins_liked,
              yellow_bins_disliked,
              blue_bins_added,
              blue_bins_liked,
              blue_bins_disliked,
            );
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  user_email,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Table(
                  columnWidths: {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            "Bins",
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Added",
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Liked",
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Disliked",
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: screenWidth * 0.1,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.TotalBinsAdded.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.TotalBinsLiked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.TotalBinsDisliked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.green,
                            size: screenWidth * 0.1,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.GreenBinsAdded.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.GreenBinsLiked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.GreenBinsDisliked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.yellow,
                            size: screenWidth * 0.1,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.YellowBinsAdded.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.YellowBinsLiked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.YellowBinsDisliked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.blue,
                            size: screenWidth * 0.1,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.BlueBinsAdded.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.BlueBinsLiked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.BlueBinsDisliked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            "Total",
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.TotalBinsAdded.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.TotalBinsLiked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            userInfo.TotalBinsDisliked.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.05),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // ElevatedButton(
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                //   ),
                //   onPressed: () {
                //     // [TODO] Navigate to edit profile page
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                //     child: Text('Edit Profile', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
                //   ),
                // ),
                // ElevatedButton(
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                //   ),
                //   onPressed: () {
                //     _showDeleteAccountDialog(context);
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                //     child: Text('Delete Account', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            // [TODO] Navigate to change email page
                            _showDialogToChangeEmail(context);
                          },
                          child: Text('Change Email', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            resetPassword();
                            _showDialogThatEmailWasSentToResetPassword(context);
                          },
                          child: Text('Change Password', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Add some space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          onPressed: () {
                            FirebaseAuthentication().signOut();
                            Navigator.pushReplacementNamed(context, '/widget_tree');
                          },
                          child: Text('Sign Out', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          onPressed: () {
                            _showDeleteAccountDialog(context);
                          },
                          child: Text('Delete Account', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Color(0xFF81C784),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
            backgroundColor: Color(0xFF81C784),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
            backgroundColor: Color(0xFF81C784),
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.white,
        onTap: (int index) {
          if (index == 0) {
            // do nothing, already on the profile screen
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/map');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/search');
          }
        },
      ),
    );
  }
}


void _showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        title: Text('Delete Account?'),
        content: Text('Are you sure you want to delete your account?'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {
              // [TODO] delete the account from firebase probably will require re-authenticate and navigate to the login screen
              Navigator.of(context).pop();
            },
            child: Text('Yes', style: TextStyle(color: Colors.white,)),
            backgroundColor: Colors.green,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No', style: TextStyle(color: Colors.white,)),
            backgroundColor: Colors.red,
          ),
        ],
      );
    },
  );
}

void _showDialogThatEmailWasSentToResetPassword(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Email Sent'),
        content: Text('An email was sent to your email address to reset your password.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void _showDialogToChangeEmail(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController _controllerEmail = TextEditingController();
      return AlertDialog(
        title: Text('Change Email'),
        content: TextField(
          controller: _controllerEmail,
          decoration: const InputDecoration(
            labelText: 'Enter your new email address',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // [TODO] change the email in firebase, probably will also have to re-authenticate
              Navigator.of(context).pop();
            },
            child: Text('Change'),
          ),
        ],
      );
    },
  );
}