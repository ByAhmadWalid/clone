import 'package:flutter/material.dart';

void main() => runApp(InstagramProfilePage());

class InstagramProfilePage extends StatelessWidget {

  final List<String> postImages = [
    'myImages/profilePost1.png',
    'myImages/profilePost2.png',
    'myImages/profilePost3.png',
    'myImages/profilePost4.png',
    'myImages/profilePost5.png',
    'myImages/profilePost6.png',
    'myImages/profilePost7.png',
    'myImages/profilePost8.png',
    'myImages/profilePost9.png',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,


          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.lock_sharp, color: Colors.black, size: 18),
              SizedBox(width: 4),
              Text(
                'jacob_w',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.black),
            ],
          ),
          centerTitle: true,
          actions: [

            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  //sidebar from the right
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),


        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(
                  'jacob_w',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Menu items based on your image
              _buildDrawerItem(Icons.history, 'Archive'),
              _buildDrawerItem(Icons.access_time, 'Your Activity'),
              _buildDrawerItem(Icons.qr_code, 'Nametag'),
              _buildDrawerItem(Icons.bookmark_border, 'Saved'),
              _buildDrawerItem(Icons.list_alt, 'Close Friends'),
              _buildDrawerItem(Icons.person_add_alt_1_outlined, 'Discover People'),
              _buildDrawerItem(Icons.facebook, 'Open Facebook'),
              const Divider(),
              _buildDrawerItem(Icons.logout, 'Logout'),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Profile Picture
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('myImages/profilePicture.png'),
                  ),

                  _buildStatColumn('54', 'Posts'),
                  _buildStatColumn('834', 'Followers'),
                  _buildStatColumn('162', 'Following'),
                ],
              ),


              // Name and Bio
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jacob West',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Text('Digital goodies designer @pixsellz'),
                      Text('Everything is designed.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Edit Profile Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 36),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder( // Added rounded border
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                  onPressed: () {},
                  child: const Text('Edit Profile',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), // Made bold
                ),
              ),

              const SizedBox(height: 12),

              // Story Highlights Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    storyCircle(Icons.add, 'New'),
                    storyCircleImage('myImages/profileStory1.png', 'Friends'),
                    storyCircleImage('myImages/profileStory2.png', 'Sport'),
                    storyCircleImage('myImages/profileStory3.png', 'Design'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Divider line
              const Divider(height: 1, color: Colors.grey),

              // Tab Icons (Grid & Tagged)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.grid_on, color: Colors.black),
                  Icon(Icons.person_pin_outlined, color: Colors.grey),
                ],
              ),



              //Grid of posts
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Use the list of images we made at the top
                  children: postImages.map((imagePath) {
                    return Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search_sharp), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined), label: ''),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('myImages/profilePicture.png'),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(color: Colors.black87, fontSize: 16)),
      onTap: () {

      },
    );
  }


  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label),
      ],
    );
  }

  Widget storyCircle(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget storyCircleImage(String imagePath, String label) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400), // Made border lighter
          ),
          child: Padding( // Added padding to prevent image from touching border
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(backgroundImage: AssetImage(imagePath)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}