class Photo{
  final String url;
  final int id;
  final String photographer;
  Photo({required this.url,required this.id,required this.photographer});

  factory Photo.fromJson(Map<String,dynamic> map){
    return Photo(
      url: map['src']["medium"] as String,
      id: map['id'] as int,
      photographer: map['photographer'] as String
    );
  }
}