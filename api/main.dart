import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:maps_client/maps_client.dart';

late GoogleMapsClient mapsClient;

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  // TODO: Consider using environment variables for the API key (e.g. envied)
  mapsClient = GoogleMapsClient(
    apiKey: 'AIzaSyCOWuPruqlwUT8DxTwQ_oZmZZ62L72fX10',
  );
  return serve(handler, ip, port);
}
