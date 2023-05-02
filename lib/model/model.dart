class MovieModel {
  String? id;
  String? title;
  String? director;
  String? image;
  String? releaseYear;

  MovieModel({
    this.id,
    this.title,
    this.director,
    this.image,
    this.releaseYear,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    director = json['category'];
    image = json['image'];
    releaseYear = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['category'] = director;
    data['image'] = image;
    data['date'] = releaseYear;
    return data;
  }

  MovieModel copyWith({
    String? id,
    String? title,
    String? director,
    String? image,
    String? releaseYear,
    bool? isChecked,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? title,
      director: director ?? this.director,
      image: image ?? this.image,
      releaseYear: releaseYear ?? this.releaseYear,
    );
  }
}
