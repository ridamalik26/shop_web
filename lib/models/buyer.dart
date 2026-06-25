import 'dart:convert';

class Buyer{
  //Define Fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  Buyer({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  //Serialization:Covert User object to a Map
  //Map: A Map is a collection of key-value pairs
  //why: Converting to a map is an intermediate step that makes it easier to serialize
  //the object to formates like Json for storage or transmission

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id":id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  //Serialization: Convert Map to a Json String
  //This method directly encodes the data from the Map into a Json String
  //The json.encode() function converts a Dart object (such as Map or list)
  //into a Json String representation, making it suitable for communication
  //between diff systems
  String toJson() => json.encode(toMap());

  //Deserialization: Convert a Map to a User Object
  //purpose - Manipulation and User : Once the data is converted a to a User object
  //it can easily manipulated and use within the application .for example
  //we might want to display the user's fullName, email etc on the Ui. or we might
  //want to save the data locally.

  //the factory constructor takes a Map(usually obtained from a Json object)
  // and converts it into a User Object.if a field is not present in the,
  //it defaults to an empty String.


  //fromMap: this constructor take a map<String, dynamic> anc convert into a user object
  // it useful when you already have the data in the map format
  factory Buyer.fromMap(Map<String, dynamic> map){
    return Buyer(
      id: (map['_id'] ?? map['id']) as String? ?? "",
      fullName: map['fullName'] as String? ?? "" ,
      email: map['email'] as String? ??"",
      state: map['state'] as String? ??"",
      city: map['city'] as String? ??"",
      locality: map['locality'] as String? ??"",
      password: map['password'] as String? ??"",
      token: map['token'] as String? ??"",

    );
  }

  //fromJson: This factory constructor takes JSon String, and decodes into a Map<String, dynamic >
  //and the uses fromMap to convert that Map a user object.

  factory Buyer.fromJson(String source) =>
      Buyer.fromMap(json.decode(source) as Map<String, dynamic>);
}