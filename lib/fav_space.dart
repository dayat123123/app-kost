// ignore_for_file: non_constant_identifier_names

class FavSpace {
  final String id_favorit;
  final String id_user;
  final String id_kost;
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
  FavSpace(
      {this.id_favorit,
      this.id_user,
      this.id_kost,
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

  factory FavSpace.fromJson(Map<String, dynamic> json) => FavSpace(
        id_favorit: json['id_favorit'],
        id_user: json['id_user'],
        id_kost: json['id_kost'],
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
