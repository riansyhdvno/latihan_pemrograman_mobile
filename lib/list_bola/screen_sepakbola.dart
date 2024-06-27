import 'package:flutter/material.dart';
import 'package:latihan_mobile/list_bola/model/sepakbola_model.dart';
import 'package:latihan_mobile/list_bola/api_sepakbola.dart';

class SepakbolaScreen extends StatefulWidget {
  @override
  _SepakbolaScreenState createState() => _SepakbolaScreenState();
}

class _SepakbolaScreenState extends State<SepakbolaScreen> {
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = ApiService().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latihan Sepak Bola'),
      ),
      body: FutureBuilder<List<Event>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return ListTile(
                  leading: event.strPoster != null
                      ? Image.network(
                    event.strPoster!,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.sports_soccer);
                    },
                  )
                      : Image.asset(
                    'gambar/bola.jpeg', // Ganti dengan path gambar bola default Anda
                    width: 50,
                  ),
                  title: Text(event.strEvent ?? 'No event name'),
                  subtitle: Text(
                      '${event.dateEvent ?? 'No date'} - ${event.strTime ?? 'No time'}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: event),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.strEvent ?? 'Event Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            event.strPoster != null
                ? Image.network(
              event.strPoster!,
              width: 150,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.sports_soccer, size: 150);
              },
            )
                : Image.asset(
              'gambar/bola.jpeg', // Ganti dengan path gambar bola default Anda
              width: 150,
            ),
            SizedBox(height: 16.0),
            Text(
              event.strEvent ?? 'No event name',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('League: ${event.strLeague ?? 'No league'}'),
                SizedBox(width: 16.0),
                Text('Season: ${event.strSeason ?? 'No season'}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Date: ${event.dateEvent ?? 'No date'}'),
                SizedBox(width: 16.0),
                Text('Time: ${event.strTime ?? 'No time'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}