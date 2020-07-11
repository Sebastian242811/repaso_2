//import 'dart:core';

class Movie {
  int id;
  String posterPath;
  String backdropPath;
  String title;
  //double voteAverage;
  String overview;
  String releaseDate;
  bool isFavorite;

  Movie(
      {
        this.id,
        this.posterPath,
        this.backdropPath,
        this.title,
        //this.voteAverage,
        this.overview,
        this.releaseDate,
        this.isFavorite
      });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
    title = json['title'];
    //voteAverage = json['vote_average'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    data['title'] = this.title;
    //data['vote_average'] = this.voteAverage.toDouble();
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'title': title,
    };
  }
}