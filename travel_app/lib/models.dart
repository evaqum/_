class Country {
  String name;
  List<Place>? places;

  Country(this.name, {this.places});

  @override
  String toString() {
    return 'Country { name: $name, places: $places }';
  }
}

class Place {
  String name;
  String? description;
  String? imageAsset;

  Place(this.name, {this.description, this.imageAsset});

  @override
  String toString() {
    return 'Place { name: $name, description: $description, imageAsset: $imageAsset }';
  }
}

final List<Country> globalCountries = [
  Country(
    'Turkey',
    places: [
      Place('Sample', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample2', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample3', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample4', imageAsset: 'assets/cappadocia.jpg'),
    ],
  ),
  Country(
    'Turkey',
    places: [
      Place('Sample', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample2', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample3', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample4', imageAsset: 'assets/cappadocia.jpg'),
    ],
  ),
  Country(
    'Turkey',
    places: [
      Place('Sample', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample2', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample3', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample4', imageAsset: 'assets/cappadocia.jpg'),
    ],
  ),
  Country(
    'Turkey',
    places: [
      Place('Sample', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample2', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample3', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample4', imageAsset: 'assets/cappadocia.jpg'),
    ],
  ),
  Country(
    'Turkey',
    places: [
      Place('Sample', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample2', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample3', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample4', imageAsset: 'assets/cappadocia.jpg'),
    ],
  ),
  Country(
    'Turkey',
    places: [
      Place('Sample', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample2', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample3', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample4', imageAsset: 'assets/cappadocia.jpg'),
    ],
  ),
  Country(
    'North Korea',
    places: [
      Place('Sample', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample2', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample3', imageAsset: 'assets/cappadocia.jpg'),
      Place('Sample4', imageAsset: 'assets/cappadocia.jpg'),
    ],
  ),
];
