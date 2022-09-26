class SearchModel {
  String name;
  String image;
  String? description;
  String? status;

  SearchModel({
    required this.name,
    required this.image,
    this.description,
    this.status,
  });
}
