import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class StructUserInfo {
  String name;
  String email;
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

  StructUserInfo(this.name, this.email, this.TotalBinsAdded, this.TotalBinsLiked, this.TotalBinsDisliked, this.BlackBinsAdded, this.BlackBinsLiked, this.BlackBinsDisliked, this.GreenBinsAdded, this.GreenBinsLiked, this.GreenBinsDisliked, this.YellowBinsAdded, this.YellowBinsLiked, this.YellowBinsDisliked, this.BlueBinsAdded, this.BlueBinsLiked, this.BlueBinsDisliked);
}

class _ProfileState extends State<Profile> {

  StructUserInfo userInfo = StructUserInfo('João Matos', 'joãomatos@gmail.com', 30, 50, 15, 10, 20, 5, 5, 10, 0, 10, 0, 5, 0, 5, 0);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            userInfo.name,
            style: TextStyle(
              fontSize: screenWidth * 0.07, // Adjust the scaling factor as needed
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userInfo.email,
            style: TextStyle(fontSize: screenWidth * 0.05),
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
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {
              // [TODO] Navigate to edit profile page
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Text('Edit Profile', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            ),
            onPressed: () {
              _showDeleteAccountDialog(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Text('Delete Account', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white)),
            ),
          ),
        ],
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
              // Action for 'Yes'.
              // You can perform the delete operation here.
              Navigator.of(context).pop();
              // Add your logic for deleting the account
            },
            child: Text('Yes', style: TextStyle(color: Colors.white,)),
            backgroundColor: Colors.green,
          ),
          FloatingActionButton(
            onPressed: () {
              // Action for 'No'.
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