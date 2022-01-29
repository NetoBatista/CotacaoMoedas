class CoinModel {
  CoinModel(this.name, this.description, this.image, this.about);
  String name;
  String description;
  String image;
  String? about;

  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'about' : about
    };
  }

  factory CoinModel.fromJson(Map<String, dynamic> json){
    return CoinModel(json['name'], json['description'], json['image'], json['about']);
  }

}