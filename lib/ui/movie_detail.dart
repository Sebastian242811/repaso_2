import 'package:flutter/material.dart';
import 'package:flutterapprepaso/models/movie.dart';
import 'package:flutterapprepaso/util/db_helper.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;

  MovieDetail(this.movie);

  @override
  _MovieDetailState createState() => _MovieDetailState(movie);
}

class _MovieDetailState extends State<MovieDetail> {
  final Movie movie;
  DbHelper dbHelper;
  String path;

  _MovieDetailState(this.movie);

  @override
  void initState() {
    dbHelper = DbHelper();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if (movie.posterPath != null) {
      path = 'https://image.tmdb.org/t/p/w500/' + movie.posterPath;
    } else {
      path = 'https://www.timandorra.com/wp-content/uploads/2016/11/Imagen-no-disponible-282x300.png';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: Hero(
                  tag: "poster_" + movie.id.toString(),
                  child: Image.network(
                    path,
                    height: height / 1.5,
                  )),
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              color: movie.isFavorite ? Colors.red : Colors.grey,
              onPressed: () {
                movie.isFavorite
                    ? dbHelper.deleteMovie(movie)
                    : dbHelper.insertMovie(movie);

                setState(() {
                  movie.isFavorite = !movie.isFavorite;
                });
              },
            ),
            Container(
                padding:
                EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                child: Text(movie.overview))
          ]),
        ),
      ),
    );
  }
}
