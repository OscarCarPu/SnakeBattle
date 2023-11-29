import 'dart:convert';
import 'package:test/test.dart';

import '../models/enums/game_mode.dart';
import '../models/enums/game_source.dart';
import '../models/game.dart';
import '../models/royale_settings.dart';
import '../models/squad_settings.dart';

void main() {
  test('It creates a Game from JSON', () {
    String jsonResponse = '''
{
    "game": {
        "id": "dfa9b3d4-831c-40dd-8621-dab104d8d41e",
        "ruleset": {
            "name": "standard",
            "version": "v1.2.3",
            "settings": {
                "foodSpawnChance": 15,
                "minimumFood": 1,
                "hazardDamagePerTurn": 0,
                "hazardMap": "",
                "hazardMapAuthor": "",
                "royale": {
                    "shrinkEveryNTurns": 0
                },
                "squad": {
                    "allowBodyCollisions": false,
                    "sharedElimination": false,
                    "sharedHealth": false,
                    "sharedLength": false
                }
            }
        },
        "map": "standard",
        "timeout": 500,
        "source": "custom"
    },
    "turn": 0,
    "board": {
        "height": 11,
        "width": 11,
        "snakes": [
            {
                "id": "gs_GmdWwDkgKvDW3YcykBRW3KHC",
                "name": "My First Battlesnake",
                "latency": "",
                "health": 100,
                "body": [
                    {
                        "x": 9,
                        "y": 9
                    },
                    {
                        "x": 9,
                        "y": 9
                    },
                    {
                        "x": 9,
                        "y": 9
                    }
                ],
                "head": {
                    "x": 9,
                    "y": 9
                },
                "length": 3,
                "shout": "",
                "squad": "",
                "customizations": {
                    "color": "#888888",
                    "head": "default",
                    "tail": "default"
                }
            }
        ],
        "food": [
            {
                "x": 8,
                "y": 10
            },
            {
                "x": 5,
                "y": 5
            }
        ],
        "hazards": []
    },
    "you": {
        "id": "gs_GmdWwDkgKvDW3YcykBRW3KHC",
        "name": "My First Battlesnake",
        "latency": "",
        "health": 100,
        "body": [
            {
                "x": 9,
                "y": 9
            },
            {
                "x": 9,
                "y": 9
            },
            {
                "x": 9,
                "y": 9
            }
        ],
        "head": {
            "x": 9,
            "y": 9
        },
        "length": 3,
        "shout": "",
        "squad": "",
        "customizations": {
            "color": "#888888",
            "head": "default",
            "tail": "default"
        }
    }
}
''';

    final Map<String, dynamic> response = json.decode(jsonResponse);
    final Game game = Game.fromJson(response['game']);

    expect(game.id, 'dfa9b3d4-831c-40dd-8621-dab104d8d41e');
    expect(game.ruleSet.name, GameMode.standard);
    expect(game.ruleSet.version, 'v1.2.3');
    expect(game.ruleSet.settings.foodSpawnChance, 15);
    expect(game.ruleSet.settings.minimumFood, 1);
    expect(game.ruleSet.settings.hazardDamagePerTurn, 0);
    expect(game.ruleSet.settings.royale is RoyaleSettings, true);
    expect(game.ruleSet.settings.squad is SquadSettings, true);
    expect(game.map, 'standard');
    expect(game.timeout, 500);
    expect(game.gameSource, GameSource.custom);
  });
}