// Name: pokedex.dart
// Function: Gen2Dex
// Description: Displays a list of pokemon with accompanying buttons. The user can press the button
//              and be taken to a page which gives them a closer description of the pokemon DetailScreen() (in individualdetail_screen.dart)
//

import 'dart:convert';
import 'dart:async';
import 'util/pokeclass.dart';
import 'util/individualdetail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Name: fetchPhotos()
// Input: http.Client
// Output: List<Pokemon>
// Description: Asynchrous. Fetches an entire json to send to another function
Future<List<Pokemon>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://raw.githubusercontent.com/hungps/flutter_pokedex/master/assets/pokemons.json'));

  // Use the compute function to run parsePhotos in a separate isolate.
  // when parsephotos returns, the computer function will create Pokemon objects in order of ascending dex-number in a list
  return compute(parsePhotos, response.body);
}

// Name: parsePhotos()
// Input: String (the String version of our json from fetchPhotos)
// Output: List<Pokemon>
// A function that converts a response body into a List<Photo>.
List<Pokemon> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
}

class Gen2Dex extends StatefulWidget {
  // Constructor
  // Input String title, int startingIdx, int endingIdx
  const Gen2Dex(
      {super.key,
      required this.title,
      required this.startingIdx,
      required this.endingIdx});

  // Data members
  final String title;
  final int startingIdx;
  final int endingIdx;

  // createState based on the below class, _Gen2DexState
  @override
  State<Gen2Dex> createState() => _Gen2DexState();
}

class _Gen2DexState extends State<Gen2Dex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PokemonsList(
              pokemons: snapshot.data!,
              startingIdx: widget.startingIdx,
              endingIdx: widget.endingIdx,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// This is the list which we scroll through
class PokemonsList extends StatelessWidget {
  const PokemonsList(
      {super.key,
      required this.pokemons,
      required this.startingIdx,
      required this.endingIdx});

  final int startingIdx;
  final int endingIdx;
  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 2,
        crossAxisCount: 2,
      ),
      itemCount: endingIdx - startingIdx,
      itemBuilder: (context, index) {
        {
          index = index + startingIdx;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: [
                    Expanded(child: Image.network(pokemons[index].imageurl)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        poke: pokemons[index],
                                      )));
                        },
                        child: Text(
                          pokemons[index].name,
                          style: const TextStyle(fontSize: 25),
                        ))
                  ],
                )),
          );
        }
      },
    );
  }
}
