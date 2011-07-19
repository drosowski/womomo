package de.womomo

class Campsite {

  String name
  String address
  Double latitude
  Double longitude

  static constraints = {
    address(nullable:true)
    latitude(nullable:true)
    longitude(nullable:true)
  }
}
