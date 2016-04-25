import 'package:start/start.dart';
import 'package:dm_rest/types/titel.dart';
import 'package:dm_rest/types/kuenstler.dart';
import 'dart:convert';
import 'dart:io' show HttpRequest, HttpStatus;
import 'package:dm_rest/types/album.dart';

main() {

  start(port: 3000).then((Server app) {

    app.static('web');

    app.get('/album').listen((request) {
      try {

        String jsonData = JSON.encode(album.albumList);
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
        var id = album.nextAlbumID();

        var new_album = new album(id, name, kuenstler, preis);
        album.addAlbum(new_album);

        for (Map m in jsonData["titel"]) {
          var name = m["name"];
          var laenge = m["laenge"];
          var kuenstler = m["kuenstler"];
          var tid = new_album.nextTitelID();
          var new_titel = new titel(tid, name, laenge, kuenstler);
          new_album.addTitel(new_titel);
        }

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send(id);

      } catch (e, st) {

        print(e);
        print(st);
        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.INTERNAL_SERVER_ERROR).send("");

      }
    });

    app.get('/album/:id').listen((request) {
      try {

        album al = album.findAlbum(request.param('id'));
        if (al == null) {
          throw("Not found");
        }

        String jsonData = JSON.encode(al);
        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send(jsonData);

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.put('/album/:id').listen((request) async {
      try {

        HttpRequest hr = request.input;
        var jsonString = await hr.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);

        album al = album.findAlbum(request.param('id'));
        if (al == null) {
          throw("Not found");
        }

        al.name = jsonData["name"];
        al.kuenstler_id = jsonData["kuenstler"];
        al.preis = jsonData["preis"];

        al.titelList.clear();

        for (Map m in jsonData["titel"]) {
          var name = m["name"];
          var laenge = m["laenge"];
          var kuenstler = m["kuenstler"];
          var new_titel = new titel(al.nextTitelID(), name, laenge, kuenstler);
          al.addTitel(new_titel);
        }

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.delete('/album/:id').listen((request) {
      try {

        if (!album.deleteAlbum(request.param('id'))) {
          throw("Not found");
        }

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.get('/album/:id/titel').listen((request) {
      try {

        album al = album.findAlbum(request.param('id'));
        if (al == null) {
          throw("Not found");
        }

        var jsonData = JSON.encode(al.titelList);

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send(jsonData);

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.post('/album/:id/titel').listen((request) async {
      try {

        HttpRequest hr = request.input;
        var jsonString = await hr.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);

        album al = album.findAlbum(request.param('id'));
        if (al == null) {
          throw("Not found");
        }

        var name = jsonData["name"];
        var laenge = jsonData["laenge"];
        var kuenstler = jsonData["kuenstler"];
        var id = al.nextTitelID();
        var new_titel = new titel(id, name, laenge, kuenstler);
        al.addTitel(new_titel);

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.get('/album/:id/titel/:tid').listen((request) {
      try {

        album al = album.findAlbum(request.param('id'));
        if (al == null) {
          throw("Not found");
        }

        titel tl = al.findTitel(request.param('tid'));
        if (tl == null) {
          throw("Not found");
        }

        String jsonData = JSON.encode(tl);

        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send(jsonData);

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }

    });

    app.put('/album/:id/titel/:tid').listen((request) async {
      try {

        HttpRequest hr = request.input;
        var jsonString = await hr.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);

        album al = album.findAlbum(request.param('id'));
        if (al == null) {
          throw("Not found");
        }

        titel tl = al.findTitel(request.param('tid'));
        if (tl == null) {
          throw("Not found");
        }

        tl.name = jsonData["name"];
        tl.laenge = jsonData["laenge"];
        tl.kuenstler_id = jsonData["kuenstler"];

      request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send("");

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.delete('/album/:id/titel/:tid').listen((request) {
      try {

        album al = album.findAlbum(request.param('id'));
        if (al == null) {
          throw("Not found");
        }

        if (!al.deleteTitel(request.param('tid'))) {
          throw("Not found");
        }

        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send("");

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.get('/kuenstler').listen((request) {
      try {

        String jsonData = JSON.encode(kuenstler.kuenstlerList);

        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send(jsonData);

      } catch (e, st) {

        print(e);
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
        var id = kuenstler.nextKuenstlerID();

        var new_kuenstler = new kuenstler(id, name, biographie, herkunft);
        kuenstler.addKuenstler(new_kuenstler);

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");

      } catch (e, st) {

        print(e);
        print(st);
        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.INTERNAL_SERVER_ERROR).send("");

      }
    });

    app.get('/kuenstler/:id').listen((request) {
      try {

        kuenstler ku = kuenstler.findKuenstler(request.param('id'));
        if (ku == null) {
          throw("Not found");
        }

        String jsonData = JSON.encode(ku);

        request.response
            .header('Content-Type', 'text/html; charset=UTF-8').status(HttpStatus.OK)
            .send(jsonData);

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.put('/kuenstler/:id').listen((request) async {
      try {

        HttpRequest hr = request.input;
        var jsonString = await hr.transform(UTF8.decoder).join();
        Map jsonData = JSON.decode(jsonString);

        kuenstler ku = kuenstler.findKuenstler(request.param('id'));
        if (ku == null) {
          throw("Not found");
        }

        ku.name = jsonData["name"];
        ku.biographie = jsonData["biographie"];
        ku.herkunft = jsonData["herkunft"];

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

    app.delete('/kuenstler/:id').listen((request) {
      try {

        if (!kuenstler.deleteKuenstler(request.param('id'))) {
          throw("Not found");
        }

        request.response.header('Content-Type', 'text/html; charset=UTF-8')
            .status(HttpStatus.OK).send("");

      } catch (e, st) {

        if (e == "Not found") {
          request.response.status(HttpStatus.NOT_FOUND).send("");
        } else {
          print(e);
          print(st);
          request.response.status(HttpStatus.INTERNAL_SERVER_ERROR).send("");
        }

      }
    });

  });
}