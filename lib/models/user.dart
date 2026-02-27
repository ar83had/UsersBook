class UsersModel{
  late int id;
  late String name;
  late String country;
  late String image;

  UsersModel({required this.id, required this.name, required this.country, required this.image});

  UsersModel.fromJson(Map<String,dynamic> json):
    id=json["id"],
    name=json["firstName"],
    country=json["country"]??"Not Mention",
    image=json["image"];
}