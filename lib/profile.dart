import 'package:flutter/material.dart';

// create a page for the profile menu

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'João Matos',
                  style: TextStyle(
                    fontSize: screenWidth * 0.07, // Adjust the scaling factor as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  'joãomatos@gmail.com',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  '300 points',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  '5 bins added',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  '15 bins liked',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: screenHeight * 0.04),
                Text(
                  '10 bins disliked',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: screenHeight * 0.06),
                ElevatedButton(
                  onPressed: () {
                    // [TODO] Navigate to edit profile page
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text('Edit Profile', style: TextStyle(fontSize: screenWidth * 0.05)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                ElevatedButton(
                  onPressed: () {
                    // [TODO] show delete account confirmation popup
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text('Delete Account', style: TextStyle(fontSize: screenWidth * 0.05)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          if (index == 0) {
            // do nothing, already on the profile screen
          } else if (index == 1) {
            Navigator.pushNamed(context, '/map');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/search');
          }
        },
      ),
    );
  }
}