import 'package:start/start.dart';
import 'package:dm_rest/types/titel.dart';
import 'package:dm_rest/types/kuenstler.dart';
import 'dart:convert';
import 'dart:async';

void main() {

  List<kuenstler> kuenstlerList = new List();
  List<titel> titelList = new List();


  start(port: 3000).then((Server app) {

    app.static('web');

    app.get('/hello/:name.:lastname?').listen((request) {
      request.response
          .header('Content-Type', 'text/html; charset=UTF-8')
          .send('Hello, ${request.param('name')} ${request.param('lastname')}');
    });

    app.ws('/socket').listen((socket) {
      socket.on('ping').listen((data) => socket.send('pong'));
      socket.on('pong').listen((data) => socket.close(1000, 'requested'));
    });

    app.get('/kuenstler').listen((request) {

      var mapData = new Map();


      int i = 0;
      for (kuenstler k in kuenstlerList) {
        var kuenstlerData = new Map();
        kuenstlerData["id"] = k.id;
        kuenstlerData["name"] = k.name;
        kuenstlerData["biographie"] = k.biographie;
        kuenstlerData["herkunft"] = k.herkunft;
        mapData[i] = kuenstlerData;
        i++;
      }
      print(mapData);

      String jsonData = JSON.encode(mapData);

      request.response
          .header('Content-Type', 'text/html; charset=UTF-8')
          .send(jsonData);
    });

    app.get('/kuenstler/:id').listen((request) {

    });

    app.post('/kuenstler').listen((request) {

      try {
        var pl = request.payload();
        pl.then((content) => print(JSON.decode(content)));
      } catch (e) {
        print(e);
      }

      var name = request.param('name');
      var biographie = request.param('biographie');
      var herkunft = request.param('herkunft');
      var new_kuenstler = new kuenstler(kuenstlerList.length, name, biographie, herkunft);
 //     kuenstlerList.add(new_kuenstler);
      print(new_kuenstler);
    });

  });
}