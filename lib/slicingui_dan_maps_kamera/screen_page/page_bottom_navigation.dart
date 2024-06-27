import 'package:flutter/material.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_camera.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_maps.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_mycourse.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_home.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_profil_user.dart';

class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<PageBottomNavigationBar> createState() => _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          PageHome(),
          PageMyCourses(),
          AksesKamera(),
          MapsFlutter(),
          //PageProfileUser(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          controller: tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Icon(Icons.article),
                    ),
                    Text("List Berita"),
                  ],
                ),
              ),
            ),
            Tab(
              child: SingleChildScrollView(// Custom layout for Tab
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),  // Control spacing between icon and text
                      child: Icon(Icons.play_arrow),
                    ),
                    Text("My Course"),
                  ],
                ),
              ),
            ),
            Tab(
              child: SingleChildScrollView(// Custom layout for Tab
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),  // Control spacing between icon and text
                      child: Icon(Icons.camera),
                    ),
                    Text("Kamera"),
                  ],
                ),
              ),
            ),
            Tab(
              child: SingleChildScrollView(// Custom layout for Tab
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 4),  // Control spacing between icon and text
                      child: Icon(Icons.maps_home_work),
                    ),
                    Text("Maps"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}