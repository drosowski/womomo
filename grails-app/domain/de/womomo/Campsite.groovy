package de.womomo

import org.grails.comments.*
import org.grails.rateable.*

class Campsite implements Commentable, Rateable {

  String name
  String address
  String country
  String city
  String region
  Double latitude
  Double longitude
  boolean closed = false

  static constraints = {
    name(blank: false, unique: true)
    address(nullable: true, blank: false)
    country(nullable: true, blank: false)
    city(nullable: true, blank: false)
    region(nullable: true, blank: false)
    latitude(nullable: true)
    longitude(nullable: true)
  }

  //static searchable = true
}
