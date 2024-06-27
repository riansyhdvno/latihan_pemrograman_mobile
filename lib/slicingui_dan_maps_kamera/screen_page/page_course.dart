import 'package:flutter/material.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_course_detail.dart';

class PageCourse extends StatefulWidget {
  const PageCourse({Key? key});

  @override
  State<PageCourse> createState() => _PageCourse();
}

class _PageCourse extends State<PageCourse> {
  final List<String> cardTitles = [
    'Machine Learning',
    'Getting Started with ML',
    'Introduction to Machine Learning',
    'PG in Machine Learning',
    'Machine Learning App',
    'Machine Learning Courses',
    'Introduction Machine Learning Courses',
    'Lets Try Machine Learning',
  ];

  final List<double> cardRatings = [4.5, 4.2, 4.1, 4.8, 4.6, 4.5, 4.6, 4.7];
  final List<int> cardViewers = [10, 10, 12, 9, 11, 13, 21, 12];

  List<String> filteredTitles = [];
  List<double> filteredRatings = [];
  List<int> filteredViewers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTitles = List.from(cardTitles);
    filteredRatings = List.from(cardRatings);
    filteredViewers = List.from(cardViewers);
  }

  void _filterCourses(String query) {
    List<String> titles = [];
    List<double> ratings = [];
    List<int> viewers = [];

    if (query.isNotEmpty) {
      for (int i = 0; i < cardTitles.length; i++) {
        if (cardTitles[i].toLowerCase().contains(query.toLowerCase())) {
          titles.add(cardTitles[i]);
          ratings.add(cardRatings[i]);
          viewers.add(cardViewers[i]);
        }
      }
    } else {
      titles = List.from(cardTitles);
      ratings = List.from(cardRatings);
      viewers = List.from(cardViewers);
    }

    setState(() {
      filteredTitles = titles;
      filteredRatings = ratings;
      filteredViewers = viewers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Machine Learning', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                _filterCourses(value);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: filteredTitles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageDetailCourse()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: CardListItem(
                        title: filteredTitles[index],
                        rating: filteredRatings[index],
                        viewers: filteredViewers[index],
                        image: AssetImage('gambar/category${index + 1}.png'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  final String title;
  final double rating;
  final int viewers;
  final ImageProvider image;

  const CardListItem({
    required this.title,
    required this.rating,
    required this.viewers,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 5),
                      Text(
                        rating.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    '$viewers k learners',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: image,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MachineLearningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machine Learning'),
      ),
      body: Center(
        child: Text('This is the Machine Learning Page'),
      ),
    );
  }
}