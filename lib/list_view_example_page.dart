import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ListViewExamplePage extends StatefulWidget {
  @override
  State<ListViewExamplePage> createState() => _ListViewExamplePageState();
}

class _ListViewExamplePageState extends State<ListViewExamplePage> {
  List<WordPair> favoritePairs = [];
  bool showFav = false;
  List<WordPair> wordPair = [];
  List<WordPair> filteredList = [];
  int currentIndex = 0;


  @override
  void initState() {
    wordPair = generateWordPairs().take(100).toList();
    filteredList = wordPair;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value; //2
            showFav = !showFav;  //true
            filteredList = showFav? favoritePairs : wordPair;
          });
        },
        backgroundColor: Colors.grey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.view_list, size: 28,), label: 'Show All', ),
            BottomNavigationBarItem(icon: Icon(Icons.favorite, size: 28,),label: 'Show Fav',backgroundColor: Colors.red, activeIcon: Icon(Icons.favorite, color: Colors.red,)),

          ]
      ),
      body: showFav?(favoritePairs.isNotEmpty? buildListView() : Center(child: Text("Please Add Some Favorite Items", style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),))) : buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final pair = filteredList[index];

        return Padding(
          padding: EdgeInsets.all(4),
          child: ListTile(
            tileColor: Colors.blueGrey.shade900,
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if (favoritePairs.contains(pair)) {
                      favoritePairs.remove(pair);
                    } else {
                      favoritePairs.add(pair);
                    }
                  });
                },
                icon: Icon(
                    favoritePairs.contains(pair)
                        ? (Icons.favorite)
                        : Icons.favorite_border,
                    color: favoritePairs.contains(pair)
                        ? Colors.red
                        : Colors.white)),
            title: RichText(
                text: TextSpan(
                    text: '${pair.first} ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    children: [
                  TextSpan(
                    text: pair.second,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  )
                ])),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey.shade900,
      title: Text('Listview Example'),
      actions: [
        TextButton(
            onPressed: () {
      setState(() {
        showFav = !showFav;
        currentIndex = showFav?1 : 0;

        filteredList = showFav? favoritePairs : wordPair;
      });
            }, child: Text(showFav?'Show all': 'Show Fav')
        )
      ],
    );
  }
}
