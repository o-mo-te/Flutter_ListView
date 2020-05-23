import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() =>  runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      // 単語のペアリングごとに一回呼び出される
      itemBuilder: (BuildContext _context, int i) {
        // 奇数だったら仕切りを追加
        if (i.isOdd) {
          return Divider();
        }
        /*
         構文 "i〜/ 2"は、iを2で除算して整数の結果を返却
         例えば、iが1、2、3、4、5の場合は0、1、1、2、2となる
         これは、ListView内の実際の単語の組み合わせ数から、仕切りウィジェットを差し引いた数を計算する
        */
        final int index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,)
    );
  }

}