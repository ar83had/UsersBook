class UsersModel{
  late int id;
  late String name;
  late String bloodG;
  late String image;

  UsersModel({required this.id, required this.name, required this.bloodG, required this.image});

  UsersModel.fromJson(Map<String,dynamic> json):
    id=json["id"],
    name=json["firstName"],
    bloodG=json["bloodGroup"]??"Not Mnetion",
    image=json["image"];
}