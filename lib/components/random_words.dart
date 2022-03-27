import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWorPairs = <WordPair>{};

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, item) {
          if (item.isOdd) return const Divider();

          final index = item ~/ 2;
          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair word) {
    final alreadySaved = _savedWorPairs.contains(word);

    return ListTile(
      title: Text(
        word.asPascalCase,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWorPairs.remove(word);
          } else {
            _savedWorPairs.add(word);
          }
        });
      },
    );
  }

//  _pushToSaved
  void _pushToSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return _savedWordPairsPage();
    }));
  }

  Widget _savedWordPairsPage() {
    final Iterable<ListTile> tiles = _savedWorPairs.map((WordPair pair) {
      return ListTile(
        title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 16.0)),
      );
    });

    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Saved Wordpair")),
      body: ListView(children: divided),
    );
  }

// Return
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "List of Wordpairs",
          ),
          actions: [
            IconButton(onPressed: _pushToSaved, icon: const Icon(Icons.list))
          ],
        ),
        body: _buildList());
  }
}
