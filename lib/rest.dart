import 'package:start/start.dart';
import 'package:dm_rest/types/titel.dart';
import 'package:dm_rest/types/kuenstler.dart';
import 'dart:convert';
import 'dart:io' show HttpRequest, HttpStatus;
import 'package:dm_rest/types/album.dart';

main() {

  List<kuenstler> kuenstlerList = new List();
  List<album> albumList = new List();

  start(port: 3000).then((Server app) {

    app.static('web');

    app.get('/album').listen((request) {
      try {
        String jsonData = JSON.encode(albumList);
        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send(jsonData);
      } catch (e, st) {
        print(st);
        request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
      }

    });

    app.post('/album').listen((request) async {

      try {
        HttpRequest hr = request.input;
        var jsonString = await hr.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);

        var name = jsonData["name"];
        var kuenstler = jsonData["kuenstler"];
        var preis = jsonData["preis"];
        var new_album = new album("a" + albumList.length.toString(), name, kuenstler, preis);
        albumList.add(new_album);

        for (Map m in jsonData["titel"]) {
          var name = m["name"];
          var laenge = m["laenge"];
          var kuenstler = m["kuenstler"];
          var new_titel = new titel("t" + new_album.titelList.length.toString(), name, laenge, kuenstler);
          new_album.addTitel(new_titel);
        }

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");
      } catch (e, st) {
        print(e);
        print(st);
        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
      }
    });

    app.get('/album/:id').listen((request) {
      try {
        album al;
        for (album a in albumList) {
          if (a.id.toString() == request.param('id')) {
            al = a;
            break;
          }
        }
        if (al == null) {
          throw("Not found");
        }
        String jsonData = JSON.encode(al);
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

    app.put('/album/:id').listen((request) {

    });

    app.delete('/album/:id').listen((request) {

    });

    app.get('/album/:id/titel').listen((request) {

    });

    app.post('/album/:id/titel').listen((request) {

    });

    app.get('/album/:id/titel/:tid').listen((request) {
      try {
        album al;
        for (album a in albumList) {
          if (a.id.toString() == request.param('id')) {
            al = a;
            break;
          }
        }
        if (al == null) {
          throw("Not found");
        }
        titel tl;
        for (titel t in al.titelList) {
          if (t.id.toString() == request.param('tid')) {
            tl = t;
            break;
          }
        }
        if (tl == null) {
          throw("Not found");
        }

        String jsonData = JSON.encode(tl);

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

    app.put('/album/:id/titel/:tid').listen((request) {

    });

    app.delete('/album/:id/titel/:tid').listen((request) {

    });

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

    app.post('/kuenstler').listen((request) async {

      try {
        HttpRequest hr = request.input;
        var jsonString = await hr.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);

        var name = jsonData["name"];
        var biographie = jsonData["biographie"];
        var herkunft = jsonData["herkunft"];
        var id;
        if (kuenstlerList.length == 0) {
          id = "k0";
        } else {
          id = "k" + ((int.parse(kuenstlerList.last.id.substring(1))) + 1).toString();
        }
        var new_kuenstler = new kuenstler(id, name, biographie, herkunft);
        kuenstlerList.add(new_kuenstler);

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");
      } catch (e) {
        print(e);
        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
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

    app.put('/kuenstler/:id').listen((request) {

    });

    app.delete('/kuenstler/:id').listen((request) {

    });

  });
}