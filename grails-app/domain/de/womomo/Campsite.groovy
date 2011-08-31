package de.womomo

import org.grails.comments.Commentable
import org.grails.rateable.Rateable

class Campsite implements Commentable, Rateable {

  String name
  String address
  String country
  String city
  String region
  Double latitude
  Double longitude
  String contact
  String remarks

  /**
   * Strom
   */
  boolean power = false

  /**
   * Ver-/Entsorgung
   */
  boolean ve = false

  boolean closed = false

  static constraints = {
    name(blank: false, unique: true)
    address(nullable: true, blank: false)
    country(nullable: true, blank: false)
    city(nullable: true, blank: false)
    region(nullable: true, blank: false)
    latitude(nullable: true)
    longitude(nullable: true)
    contact(nullable: true, blank: false)
    remarks(nullable: true, blank: false)
  }

  //static searchable = true
}
