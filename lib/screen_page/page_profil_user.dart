// import 'package:flutter/material.dart';
// import 'package:project4_slicingui/screen_page/page_mycourse.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Online Learning App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hello Liza!'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Handle search action
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 //color: Colors.blue,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 450, // Sesuaikan lebar sesuai kebutuhan Anda
//                     height: 220, // Sesuaikan tinggi sesuai kebutuhan Anda
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/gambar/gambar1.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 7),
//             Container(
//               padding: EdgeInsets.only(
//                   left: 16,
//                   right: 16), // Atur padding hanya pada sisi kiri
//               child: Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start, // Atur posisi lintang ke kiri
//                 children: [
//                   Text(
//                     'Categories',
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => PageMyCourses()),
//                             );
//                           },
//                           child: CategoryCard(
//                             title: 'Cyber Security',
//                             courseCount: 145,
//                             icon: Icons.security,
//                             width: 180,
//                             height: 82,
//                           ),
//                         ),
//                         CategoryCard(
//                           title: 'Data Science',
//                           courseCount: 120,
//                           icon: Icons.computer,
//                           width: 173,
//                           height: 82,
//                         ),
//                         CategoryCard(
//                           title: 'Mobile',
//                           courseCount: 50,
//                           icon: Icons.mobile_screen_share,
//                           width: 150,
//                           height: 82,
//                         ),
//                         CategoryCard(
//                           title: 'Networking',
//                           courseCount: 130,
//                           icon: Icons.laptop_chromebook,
//                           width: 173,
//                           height: 82,
//                         ),
//                         // Add more categories here
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Top Courses',
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   SingleChildScrollView(
//                     // Widget untuk membuat kartu kursus bersebelahan
//                     scrollDirection: Axis.horizontal,
//                     // Atur scroll direction menjadi horizontal
//                     child: Row(
//                       children: [
//                         SizedBox(
//                             width: 16), // Spacer sebelum kartu kursus pertama
//                         CourseCard(
//                           title: 'Data Science',
//                           rating: 4.6,
//                           learners: 10500,
//                           image: 'assets/gambar/gambar2.png',
//                           // Tambahkan path gambar untuk top course
//                         ),
//                         SizedBox(width: 16), // Spacer antara kartu kursus
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => PageMyCourses()),
//                             );
//                           },
//                           child:
//                           CourseCard(
//                             title: 'Machine Learning',
//                             rating: 4.6,
//                             learners: 10500,
//                             image: 'assets/gambar/gambar3.png',
//                             // Tambahkan path gambar untuk top course
//                           ),
//                         ),
//                         SizedBox(width: 16), // Spacer antara kartu kursus
//                         CourseCard(
//                           title: 'Machine Learning',
//                           rating: 4.6,
//                           learners: 10500,
//                           image: 'assets/gambar/gambar2.png',
//                           // Tambahkan path gambar untuk top course
//                         ),
//                         // Add more top courses here
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Popular Blogs',
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   SingleChildScrollView(
//                     // Widget untuk membuat kartu kursus bersebelahan
//                     scrollDirection: Axis.horizontal,
//                     // Atur scroll direction menjadi horizontal
//                     child: Row(
//                       children: [
//                         SizedBox(
//                             width: 16), // Spacer sebelum kartu kursus pertama
//                         BlogCard(
//                           author: 'Rian Mendella',
//                           title: 'How to improve Microsoft Excel Skills',
//                           content:
//                           'Most people know the power Excel can wield, especially when used properly. But fewer people know how to make the most of Excel...',
//                           image: 'assets/gambar/gambar4.png',
//                           // Tambahkan path gambar untuk top course
//                         ),
//                         SizedBox(width: 16), // Spacer antara kartu kursus
//                         BlogCard(
//                           author: 'Liza Nisel',
//                           title: 'Top 10 Java Tools for 2021',
//                           content:
//                           'Java is the most widely used high level object oriented programming language across the globe. Oracle Corporation purchased SUN MiCROSYSTEM in 2010...',
//                           image: 'assets/gambar/gambar4.png',
//                           // Tambahkan path gambar untuk top course
//                         ),
//                         // Add more top courses here
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryCard extends StatelessWidget {
//   final String title;
//   final int courseCount;
//   final double width;
//   final double height;
//   final IconData icon;
//
//   CategoryCard({
//     required this.title,
//     required this.courseCount,
//     this.width = 200,
//     this.height = 100,
//     required this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 3,
//             blurRadius: 3,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 4), // Reduced spacing for closer text elements
//               Text('$courseCount Courses'),
//             ],
//           ),
//           Icon(icon, size: 30, color: Color(0xFF1E0094)),
//         ],
//       ),
//     );
//   }
// }
//
// class CourseCard extends StatelessWidget {
//   final String title;
//   final double rating;c
//   final int learners;
//   final String image;
//
//   CourseCard({
//     required this.title,
//     required this.rating,
//     required this.learners,
//     required this.image,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200, // Lebar kartu kursus
//       padding: EdgeInsets.all(0),
//       decoration: BoxDecoration(
//         color: Colors.white, // Mengatur warna latar belakang menjadi putih
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(8),
//           topRight: Radius.circular(8),
//           bottomLeft: Radius.circular(8),
//           bottomRight: Radius.circular(8),
//         ),
//         boxShadow: [
//           // Menambahkan shadow
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5), // Warna shadow
//             spreadRadius: 1, // Radius penyebaran shadow
//             blurRadius: 2, // Radius blur shadow
//             offset: Offset(0, 2), // Offset shadow (x, y)
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start, // Change this line
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(8),
//               topRight: Radius.circular(8),
//             ),
//             child: Image.asset(
//               image,
//               width: 250,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ), // Tampilkan gambar pada top course
//           SizedBox(height: 4),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 8), // Padding kiri dan kanan
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.left, // Add this line
//             ),
//           ),
//           SizedBox(height: 2),
//           Row(
//             children: [
//               SizedBox(width: 2),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 8), // Padding kiri dan kanan
//                 child: Text('$rating ★', textAlign: TextAlign.left),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 8), // Padding kiri dan kanan
//                   child: Text('$learners Learners',
//                       textAlign: TextAlign.right), // Pelajar di sebelah kanan
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8), // Menambahkan ruang di bawah
//         ],
//       ),
//     );
//   }
// }
//
// class BlogCard extends StatelessWidget {
//   final String author;
//   final String title;
//   final String content;
//   final String image;
//
//   BlogCard({
//     required this.author,
//     required this.title,
//     required this.content,
//     required this.image,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300, // Adjust the width as needed
//       padding: EdgeInsets.all(0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(8),
//               bottomLeft: Radius.circular(8),
//             ),
//             child: Image.asset(
//               image,
//               width: 140,
//               height: 150,
//               fit: BoxFit.cover,
//             ),
//           ), // Display image
//           SizedBox(width: 6), // Space between image and text
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   'By $author',
//                   style: TextStyle(
//                     fontSize: 15,
//                   ),
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 3),
//                 Text(
//                   content,
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }