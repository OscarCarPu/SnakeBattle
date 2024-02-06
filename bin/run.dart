import 'dart:io';
import 'dart:convert';
import 'dart:math';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/enums/direction.dart';
import '../models/enums/heads.dart';
import '../models/enums/tails.dart';
import '../models/main_response.dart';

/// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/start', _startHandler)
  ..post('/move', _moveHandler)
  ..post('/end', _endHandler);

/// Convenience method for returning a JSON response
Response _jsonResponse(encodable) => Response.ok(json.encode(encodable),
    headers: {'Content-Type': 'application/json'});

/// Request handler for the root path
Response _rootHandler(Request req) {
  // Your main configuration. Specify your details here.
  final mainResponse = MainResponse(
    apiVersion: '1',
    author: 'Battlesnake',
    color: '#eb6433',
    head: Heads.defaultHead,
    tail: Tails.defaultTail,
  );

  return _jsonResponse(mainResponse);
}

/// Request handler for the Start path
Future<Response> _startHandler(Request request) async {
  final gameData = await request.readAsString();

  print('START');
  return Response.ok('ok');
}

List<Direction> logicalMoves(game){
  List<Direction> moves;
  for(dir in Direction.values){
        var position = data['you']['head'];
    switch(move){
      case Direction.up:
        position['y']++;
        break;
      case Direction.down:
        position['y']--;
        break;
      case Direction.left:
        position['x']--;
        break;
      case Direction.right:
        position['x']++;
        break;
      default:break;
    }
    if(position['x'] >= 0 && position['x'] < data['board']['width'] && position['y'] >= 0 && position['y'] < data['board']['height']){
      bool allLegal = true;
      for(var pos in data['you']['body']){
        if(pos['x'] == position['x'] && pos['y'] == position['y']){
          allLegal = false;
        }
      }
      if(allLegal){
        legal = true;
      }
    }
        switch(move){
      case Direction.up:
        position['y']--;
        break;
      case Direction.down:
        position['y']++;
        break;
      case Direction.left:
        position['x']++;
        break;
      case Direction.right:
        position['x']--;
        break;
      default:break;
    }
  }
}


/// Request handler for the Move path
Future<Response> _moveHandler(Request request) async {
  final gameData = await request.readAsString();
    var data = json.decode(gameData);
  // All the possible and logical moves
  final logicalMoves = logicalMoves(data)
  // choose a move based on logic... random, in this case.
  var move = Direction.down;

  bool legal = false;
  do{
    move = possibleMoves.elementAt(Random().nextInt(possibleMoves.length));
    var position = data['you']['head'];
    switch(move){
      case Direction.up:
        position['y']++;
        break;
      case Direction.down:
        position['y']--;
        break;
      case Direction.left:
        position['x']--;
        break;
      case Direction.right:
        position['x']++;
        break;
      default:break;
    }
    if(position['x'] >= 0 && position['x'] < data['board']['width'] && position['y'] >= 0 && position['y'] < data['board']['height']){
      bool allLegal = true;
      for(var pos in data['you']['body']){
        if(pos['x'] == position['x'] && pos['y'] == position['y']){
          allLegal = false;
        }
      }
      if(allLegal){
        legal = true;
      }
    }
        switch(move){
      case Direction.up:
        position['y']--;
        break;
      case Direction.down:
        position['y']++;
        break;
      case Direction.left:
        position['x']++;
        break;
      case Direction.right:
        position['x']--;
        break;
      default:break;
    }
  }while(!legal);
  print('MOVE: ${move.name}');

  final moveResponse = {
    'move': move.name,
    'shout': move.name
  };
  return _jsonResponse(moveResponse);
}

/// Request handler for the End path
Future<Response> _endHandler(Request request) async {
  final gameData = await request.readAsString();

  // TODO: clear game state, the game is over
  print('END');
  return Response.ok('ok');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  print('Dart Shelf Battlesnake Server listening at port ${server.port}');
}
