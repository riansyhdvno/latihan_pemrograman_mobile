import 'package:flutter/material.dart';
import 'package:project_slicingui/screen_page/page_course.dart';

void main() {
  runApp(PageDetailCourse());
}

class PageDetailCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Machine Learning'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PageCourse()),
              // );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search button press
              },
            ),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('gambar/category8.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Machine Learning',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '4.5 ★ 10.5k Learners',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TabBar(
                tabs: [
                  Tab(text: 'Overview'),
                  Tab(text: 'Lectures'),
                  Tab(text: 'Similar Courses'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OverviewTab(),
                    LecturesTab(),
                    SimilarCoursesTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.access_time), // Icon for time
              title: Text('6 Hours'),
            ),
            ListTile(
              leading: Icon(Icons.verified), // Icon for certificate
              title: Text('Completion Certificate'),
            ),
            ListTile(
              leading: Icon(Icons.bar_chart), // Icon for level
              title: Text('Beginner'),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What will I learn?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The Machine learning basics program is designed to offer a solid foundation & work-ready skills for ML engineers. The Machine learning basics program is designed to offer a solid foundation & work-ready skills for ML engineers.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rating and Reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Text(
                    '4.5',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star_half, color: Colors.amber, size: 20),
                    ],
                  ),
                  SizedBox(width: 8),
                  Text(
                    '15 reviews',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Background color
                  foregroundColor: Colors.white, // Text color
                ),
                onPressed: () {
                  // Handle button press
                },
                child: Text('Start Learning'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LecturesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Lectures content goes here'),
    );
  }
}

class SimilarCoursesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Similar courses content goes here'),
    );
  }
}