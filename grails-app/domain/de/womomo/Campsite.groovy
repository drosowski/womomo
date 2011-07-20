package de.womomo

class Campsite {

  String name
  String address
  String country
  String city
  String region
  Double latitude
  Double longitude

  static constraints = {
    name(blank: false, unique: true)
    address(nullable: true, blank: false)
    country(nullable: true, blank: false)
    city(nullable: true, blank: false)
    region(nullable: true, blank: false)
    latitude(nullable: true)
    longitude(nullable: true)
  }
}
