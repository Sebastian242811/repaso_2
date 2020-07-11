import 'package:flutter/material.dart';
import 'package:flutterapprepaso/models/movie.dart';
import 'package:flutterapprepaso/util/db_helper.dart';
import 'package:flutterapprepaso/util/http_helper.dart';

import 'package:flutterapprepaso/ui/movie_detail.dart';

class MovieList extends StatefulWidget{
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList>{
  List movies;
  int moviesCount;
  int page = 1;
  bool loading = true;
  ScrollController _scrollController;

  HttpHelper helper;

  Future initialize() async{
    movies = List();
    loadMore();
    initScrollController();
  }

  @override
  void initState(){
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming movies!!!'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index){
          return MovieRow(movies[index]);
        },
      ),
    );
  }

  void loadMore() {
    helper.getUpcoming(page.toString()).then((value){
      movies += value;
      setState(() {
        moviesCount = movies.length;
        movies = movies;
        page++;
      });

    if (movies.length % 20 > 0){
      loading = false;
    }
    });
  }

  void initScrollController() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
      && loading){
        loadMore();
      }
    });
  }
}

class MovieRow extends StatefulWidget {
  final Movie movie;
  MovieRow(this.movie);

  @override
  _MovieRowState createState() => _MovieRowState(movie);
}

class _MovieRowState extends State<MovieRow> {
  final Movie movie;
  _MovieRowState(this.movie);

  bool favorite;
  DbHelper dbHelper;
  String path;

  @override
  void initState(){
    favorite = false;
    dbHelper = DbHelper();
    isFavorite(movie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (movie.posterPath != null){
      path = 'https://image.tmdb.org/t/p/w500'+movie.posterPath;
    }
    else{
      path = 'https://www.timandorra.com/wp-content/uploads/2016/11/Imagen-no-disponible-282x300.png';
    }

    return Card(
      color: Colors.limeAccent,
      elevation: 20.0,
      child: ListTile(
        leading: Image.network(path),
        title: Text(widget.movie.title),
        subtitle: Text(widget.movie.releaseDate),
        onTap: (){
          Navigator.push(
              context,
          MaterialPageRoute(
            builder: (BuildContext context) => MovieDetail(widget.movie)
          ),
          ).then((value) {
            isFavorite(movie);
          });
        },
        trailing: IconButton(
          icon: Icon(Icons.favorite),
          color: favorite ? Colors.red : Colors.grey,
          onPressed: (){
            favorite ? dbHelper.deleteMovie(movie) : dbHelper.insertMovie(movie);
            setState(() {
              favorite = !favorite;
              movie.isFavorite = favorite;
            });
          },
        ),
      ),
    );
  }

  Future isFavorite(Movie movie) async{
    await dbHelper.openDb();
    favorite = await dbHelper.isFavorite(movie);
    setState(() {
      movie.isFavorite = favorite;
    });
  }
}