import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Events',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MusicEventScreen(),
    );
  }
}

class MusicEventScreen extends StatefulWidget {
  @override
  _MusicEventScreenState createState() => _MusicEventScreenState();
}

class _MusicEventScreenState extends State<MusicEventScreen> {
  List<dynamic> musicEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchMusicEvents();
  }

  Future<void> _fetchMusicEvents() async {
    try {
      final List<dynamic> fetchedMusicEvents =
          await ApiService.fetchMusicEvents();
      setState(() {
        musicEvents = fetchedMusicEvents;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Events'),
      ),
      body: ListView.builder(
        itemCount: musicEvents.length,
        itemBuilder: (context, index) {
          final musicEvent = musicEvents[index];
          List<dynamic> artists = musicEvent['daftar_artis'];
          String artistNames =
              artists.map((artist) => artist['nama']).join(', ');

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    musicEvent['informasi_acara']['nama_acara'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    musicEvent['informasi_acara']['tanggal_waktu'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Lokasi: ${musicEvent['informasi_acara']['lokasi']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Deskripsi: ${musicEvent['informasi_acara']['deskripsi']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Artis: $artistNames',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
