import 'package:start/start.dart';
import 'package:dm_rest/types/titel.dart';
import 'package:dm_rest/types/kuenstler.dart';
import 'dart:convert';
import 'dart:io' show HttpRequest, HttpStatus;
import 'dart:async';

main() {

  List<kuenstler> kuenstlerList = new List();
  List<titel> titelList = new List();


  start(port: 3000).then((Server app) {

    app.static('web');

    app.get('/kuenstler').listen((request) {

      try {
        String jsonData = JSON.encode(kuenstlerList);

        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send(jsonData);
      } catch (e, st) {
        print(st);
        request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
      }

    });

    app.get('/kuenstler/:id').listen((request) {
      try {

        kuenstler ku;
        for (kuenstler k in kuenstlerList) {
          if (k.id.toString() == request.param('id')) {
            ku = k;
            break;
          }
        }
        if (ku == null) {
          throw("Not found");
        }

        String jsonData = JSON.encode(ku);

        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send(jsonData);
      } catch (e, st) {
        if (e == "Not Found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }
      }
    });

    app.post('/kuenstler').listen((request) async {

      try {
        HttpRequest hr = request.input;
        var jsonString = await hr.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);

        var name = jsonData["name"];
        var biographie = jsonData["biographie"];
        var herkunft = jsonData["herkunft"];
        var new_kuenstler = new kuenstler(
            kuenstlerList.length, name, biographie, herkunft);
        kuenstlerList.add(new_kuenstler);
        print(new_kuenstler);

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");
      } catch (e) {
        print(e);
        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
      }
    });

  });
}