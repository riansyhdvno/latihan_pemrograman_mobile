import 'package:flutter/material.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_category.dart';
import 'package:latihan_mobile/slicingui_dan_maps_kamera/screen_page/page_course.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Siang, Vano!'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Aksi yang ingin dilakukan ketika tombol pencarian ditekan
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Search Dialog'),
                    content: Text('Tombol pencarian ditekan!'),
                    actions: [
                      TextButton(
                        child: Text('Tutup'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200, // Tinggi untuk carousel
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(), // Tambahkan ini
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Jumlah item di carousel
                itemBuilder: (BuildContext context, int index) {
                  // Ganti dengan path relatif dari gambar di dalam direktori assets
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9, // Lebar carousel, misal 80% dari lebar layar
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('gambar/img.png'), // Ganti dengan path gambar sesuai kebutuhan
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20), // Jarak antara carousel dan teks
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20), // Margin horizontal untuk teks
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center, // Opsional: Mengatur teks menjadi rata tengah
              ),
            ),


            SizedBox(height: 5), // Jarak antara carousel dan card
            Container(
              height: 120, // Tinggi untuk card
              margin: EdgeInsets.only(left: 8), // Margin horizontal untuk kartu
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8), // Memberikan padding di sebelah kanan ListView
                itemCount: 4, // Menambah jumlah kategori menjadi 4
                itemBuilder: (BuildContext context, int index) {
                  String title = '';
                  String subTitle = '';
                  IconData? icon; // Menggunakan tipe data nullable karena dapat kosong

                  // Menentukan konten berdasarkan index
                  switch (index) {
                    case 0:
                      title = 'Cyber Security';
                      subTitle = '145 Courses';
                      icon = Icons.security;
                      break;
                    case 1:
                      title = 'Data Science';
                      subTitle = '120 Courses';
                      icon = Icons.cloud;
                      break;
                    case 2: // Kategori baru
                      title = 'Cisco Tracer';
                      subTitle = '190 Courses';
                      icon = Icons.lightbulb_outline;
                      break;
                    case 3: // Kategori baru
                      title = 'Mobile Dev';
                      subTitle = '100 Courses';
                      icon = Icons.phone_android;
                      break;
                  }

                  return GestureDetector(
                    onTap: () {
                      // Pindah ke PageCyberSecurity saat card diklik
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageCyberSecurity()),
                      );
                    },
                    child: Container(
                      width: 200, // Lebar item card
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna putih untuk kartu
                        borderRadius: BorderRadius.circular(10), // Sudut kartu dibulatkan
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Warna bayangan
                            spreadRadius: 2, // Penyebaran bayangan
                            blurRadius: 5, // Ukuran blur bayangan
                            offset: Offset(0, 3), // Posisi bayangan
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 25, top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end, // Posisi ikon ke kanan
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title, // Judul kartu
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4), // Jarak antara judul dan jumlah kursus
                                Text(
                                  subTitle, // Jumlah kursus
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(width: 8), // Jarak antara teks dan ikon
                            if (icon != null) // Menambahkan icon jika tidak null
                              Icon(
                                icon,
                                size: 40,
                                color: Colors.deepPurple, // Warna ikon
                              ), // Ikon
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),


            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20), // Margin horizontal untuk teks
              child: Text(
                'Top Course',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center, // Opsional: Mengatur teks menjadi rata tengah
              ),
            ),

            SizedBox(height: 5),
            Container(
              height: 230, // Tinggi untuk card, disesuaikan agar cukup untuk gambar dan teks
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 16), // Padding awal
                  // Card untuk Data Science
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageCourse()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5, // Lebar card
                      margin: EdgeInsets.only(right: 16), // Jarak antar card
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3, // Tingkat shadow
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: SizedBox(
                                height: 150, // Tinggi gambar
                                width: double.infinity,
                                child: Image.asset(
                                  'gambar/topcourse1.png', // Gambar Data Science
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Data Science', // Judul Data Science
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 4), // Jarak antara judul dan rating
                                  Row(
                                    children: [
                                      Text(
                                        '4.5', // Penilaian Data Science
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 4), // Jarak antara teks dan ikon
                                      Icon(
                                        Icons.star, // Ikon bintang
                                        color: Colors.black45,
                                      ),
                                      SizedBox(width: 8), // Jarak antara rating dan learners
                                      Text(
                                        '10500 Learners', // Jumlah learners Data Science
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Card untuk Machine Learning
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageCourse()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5, // Lebar card
                      margin: EdgeInsets.only(right: 16), // Jarak antar card
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3, // Tingkat shadow
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: SizedBox(
                                height: 150, // Tinggi gambar
                                width: double.infinity,
                                child: Image.asset(
                                  'gambar/topcourse2.png', // Gambar Machine Learning
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Machine Learning', // Judul Machine Learning
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 4), // Jarak antara judul dan rating
                                  Row(
                                    children: [
                                      Text(
                                        '4.6', // Penilaian Machine Learning
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 4), // Jarak antara teks dan ikon
                                      Icon(
                                        Icons.star, // Ikon bintang
                                        color: Colors.black45,
                                      ),
                                      SizedBox(width: 8), // Jarak antara rating dan learners
                                      Text(
                                        '14500 Learners', // Jumlah learners Machine Learning
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Card untuk Mobile Learning
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageCourse()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5, // Lebar card
                      margin: EdgeInsets.only(right: 16), // Jarak antar card
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3, // Tingkat shadow
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: SizedBox(
                                height: 150, // Tinggi gambar
                                width: double.infinity,
                                child: Image.asset(
                                  'gambar/topcourse3.png', // Gambar Mobile Learning
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mobile Learning', // Judul Mobile Learning
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 4), // Jarak antara judul dan rating
                                  Row(
                                    children: [
                                      Text(
                                        '4.9', // Penilaian Mobile Learning
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 4), // Jarak antara teks dan ikon
                                      Icon(
                                        Icons.star, // Ikon bintang
                                        color: Colors.black45,
                                      ),
                                      SizedBox(width: 8), // Jarak antara rating dan learners
                                      Text(
                                        '9000 Learners', // Jumlah learners Mobile Learning
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Padding akhir
                ],
              ),
            ),



            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20), // Margin horizontal untuk teks
              child: Text(
                'Popular Blogs',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center, // Opsional: Mengatur teks menjadi rata tengah
              ),
            ),

            SizedBox(height: 5),
            Container(
              height: 230, // Tinggi untuk card
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 16), // Padding awal
                  // Card untuk How to improve Microsoft Excel Skills
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7, // Lebar card
                    margin: EdgeInsets.only(right: 16), // Jarak antar card
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3, // Tingkat shadow
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: SizedBox(
                              height: double.infinity, // Tinggi gambar mengisi seluruh tinggi card
                              width: MediaQuery.of(context).size.width * 0.35, // Lebar gambar (setengah dari lebar card)
                              child: Image.asset(
                                'gambar/topcourse1.png', // Gambar category1
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rian Mendella',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'How to improve Microsoft Excel Skills',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4), // Jarak antara judul dan rating
                                  Text(
                                    'Most people know the power Excel can wield, especially when used properly. But fewer people know how to make the most of Excel...', // Isi berita
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Card untuk Top 10 Java Tools for 2021
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7, // Lebar card
                    margin: EdgeInsets.only(right: 16), // Jarak antar card
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3, // Tingkat shadow
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: SizedBox(
                              height: double.infinity, // Tinggi gambar mengisi seluruh tinggi card
                              width: MediaQuery.of(context).size.width * 0.35, // Lebar gambar (setengah dari lebar card)
                              child: Image.asset(
                                'gambar/topcourse3.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Top 10 Java Tools for 2021',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4), // Jarak antara judul dan rating
                                  Text(
                                    'Java is the most widely used high level object oriented programming language across the globe. Oracle Corporation purchased SUN Microsystems in 2010...', // Isi berita
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Padding akhir
                ],
              ),
            ),







          ],
        ),
      ),
    );
  }
}
