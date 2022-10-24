class Space {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String city;
  final String country;
  final String rating;
  final String address;
  final String phone;
  final String mapUrl;
  final String photos;
  final String numberOfKitchens;
  final String numberOfBedrooms;
  final String numberOfCupboards;
  final String status;
  Space(
      {this.id,
      this.name,
      this.imageUrl,
      this.price,
      this.city,
      this.country,
      this.rating,
      this.address,
      this.phone,
      this.mapUrl,
      this.photos,
      this.numberOfBedrooms,
      this.numberOfCupboards,
      this.numberOfKitchens,
      this.status});

  factory Space.fromJson(Map<String, dynamic> json) => Space(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        price: json['price'],
        city: json['city'],
        country: json['country'],
        rating: json['rating'],
        address: json['address'],
        phone: json['phone'],
        mapUrl: json['mapUrl'],
        photos: json['photos'],
        numberOfBedrooms: json['numberOfBedrooms'],
        numberOfCupboards: json[' numberOfCupboards'],
        numberOfKitchens: json['numberOfKitchens'],
        status: json['status'],
      );
}
