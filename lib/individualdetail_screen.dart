// Name: individualdetail_screen.dart
// Function: DetailScreen()
// Description: For use in pokedex.dart
//              Displays the information of a single pokemon
//              Uses utility from detail_util.dart
//

import 'package:flutter/material.dart';
import 'util/detail_util.dart';
import 'util/pokeclass.dart';

class DetailScreen extends StatefulWidget {
  final Pokemon poke;
  const DetailScreen({super.key, required this.poke});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 151, 143),
        // define the BG color of the whole page
        // appBar on the top of the screen "title bar"
        appBar: AppBar(title: Text("The ${widget.poke.category} Pokémon")),
        body: Column(
          children: [
            pokeName(widget.poke.name),
            pokeFace(widget.poke.imageurl),
            pokeTypes(widget.poke.typeofpokemon),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  pokeStats(
                      widget.poke.hp,
                      widget.poke.attack,
                      widget.poke.defense,
                      widget.poke.special_attack,
                      widget.poke.special_defense,
                      widget.poke.speed,
                      widget.poke.total),
                  spacer(),
                  spacer(),
                  pokeDesc(widget.poke.xdescription)
                ],
              ),
            ),
          ],
        ));
  }
}
