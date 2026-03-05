class DummyModel{
  late int id;
  late String name;
  late String bloodG;
  late String image;
  late String firstName;
  late String maidenName;
  late String lastName;
  late int age;
  late String gender;
  late String email;
  late String phone;
  late Map<String,dynamic> address;


  DummyModel({required this.id, required this.name, required this.bloodG, required this.image});

  DummyModel.fromJson(Map<String,dynamic> json):
    id=json["id"],
    name=json["firstName"],
    bloodG=json["bloodGroup"]??"Not Mnetion",
    image=json["image"],
    firstName=json["firstName"],
    maidenName=json["maidenName"],
    lastName=json["lastName"],
    age=json["age"],
    gender=json["gender"],
    email=json["email"],
    phone=json["phone"],
    address=json["address"];
}