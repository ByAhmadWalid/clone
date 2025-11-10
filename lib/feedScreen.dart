import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InstagramFeedPage(),
    );
  }
}

class InstagramFeedPage extends StatelessWidget {
  const InstagramFeedPage({super.key});


  final List<Map<String, dynamic>> postData = const [
    {
      "username": "joshua_l",
      "location": "Tokyo, Japan",
      "imagePaths": [
        'myImages/feedPost1.png',
        'myImages/feedPost2.png',
        'myImages/feedPost1.png'
      ],
      "caption":
      "The game in Japan was amazing and I want to share some photos",
      "likes": "44,686",
      "date": "September 19",
    },
    {
      "username": "joshua_l",
      "location": "Tokyo, Japan",
      "imagePaths": [
        'myImages/feedPost2.png' // This post only has one image
      ],
      "caption":
      "The game in Japan was amazing and I want to share some photos",
      "likes": "44,686",
      "date": "September 19",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset('myIcons/Camera.png', width: 25),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('myIcons/IGTV.png', width: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('myIcons/Messenger.png', width: 24),
          ),
        ],
      ),


      body: ListView.builder(
        // The total number of items is stories + divider + number of posts
        itemCount: 1 + 1 + postData.length,
        itemBuilder: (context, index) {
          // Item 0 is the stories
          if (index == 0) {
            return SizedBox(
              height: 105,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                children: [
                  storyCircle('Your Story', 'myImages/profilePicture.png'),
                  storyCircle('karennne', 'myImages/feedStory1.png',
                      isLive: true),
                  storyCircle('zackjohn', 'myImages/feedStory2.png'),
                  storyCircle('kieron_d', 'myImages/feedStory3.png'),
                  storyCircle('craig_love', 'myImages/feedStory4.png'),
                ],
              ),
            );
          }
          // Item 1 is the divider
          else if (index == 1) {
            return const Divider(height: 1);
          }
          // All other items are posts
          // We subtract 2 to get the correct post index from postData
          final postIndex = index - 2;
          final post = postData[postIndex];

          return PostWidget(
            username: post['username'],
            location: post['location'],
            imagePaths: post['imagePaths'],
            caption: post['caption'],
            likes: post['likes'],
            date: post['date'],
          );
        },
      ),

      //Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_sharp), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search_sharp), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: ''),
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
    );
  }

  //Story Widget
  static Widget storyCircle(String username, String imagePath,
      {bool isLive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(251, 170, 71, 1),
                  Color.fromRGBO(217, 26, 70, 1),
                  Color.fromRGBO(166, 15, 147, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: CircleAvatar(
                backgroundImage: AssetImage(imagePath),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(username,
                  style: const TextStyle(fontSize: 10, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}


class PostWidget extends StatefulWidget {
  final String username;
  final String location;
  final List<String> imagePaths; // Changed from String to List<String>
  final String caption;
  final String likes;
  final String date;

  const PostWidget({
    super.key,
    required this.username,
    required this.location,
    required this.imagePaths,
    required this.caption,
    required this.likes,
    required this.date,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  //keep track of the current page
  int _currentPage = 0;
  //add a new boolean to track the like state
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    // Check if the post has multiple images
    final bool hasMultipleImages = widget.imagePaths.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('myImages/feedPost0.png'),
          ),
          title: Row(
            children: [
              Text(widget.username,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(width: 4),
              const Icon(Icons.verified, color: Colors.blue, size: 14),
            ],
          ),
          subtitle: Text(widget.location),
          trailing: const Icon(Icons.more_horiz),
        ),

        //Post Image(s) - Stack
        Stack(
          alignment: Alignment.center,
          children: [
            //PageView for swiping
            AspectRatio(
              aspectRatio: 1,
              child: PageView.builder(
                // This updates the _currentPage variable when swiping
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: widget.imagePaths.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    widget.imagePaths[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            //Page Label (1/3)
            if (hasMultipleImages)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    // Page number logic
                    '${_currentPage + 1}/${widget.imagePaths.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),

            //Page Indicator Dots
            if (hasMultipleImages)
              Positioned(
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.imagePaths.length, // Number of dots
                        (index) {
                      return Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: _currentPage == index // Active dot is blue
                              ? Colors.blue
                              : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),

        // Post Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [

                GestureDetector(
                  onTap: () {
                    // When tapped, we call setState to rebuild the widget
                    setState(() {
                      // We toggle the _isLiked variable
                      _isLiked = !_isLiked;
                    });
                  },
                  child: _isLiked
                  // If liked, show the filled red heart
                      ? const Icon(Icons.favorite, color: Color.fromRGBO(255, 0, 0, 1), size: 26)
                  // If not liked, show the empty border heart
                      : const Icon(Icons.favorite_border, size: 26),
                ),

                const SizedBox(width: 12),
                Image.asset('myIcons/comment.png', width: 26),
                const SizedBox(width: 12),
                Image.asset('myIcons/share.png', width: 26),
              ]),
              Image.asset('myIcons/save.png', width: 24),
            ],
          ),
        ),

        // Likes and Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Liked by craig_love and ${widget.likes} others',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: '${widget.username} ',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: widget.caption),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(widget.date,
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}