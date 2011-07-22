package de.womomo

class CampsiteService {

  def googleService

  static transactional = false

  /**
   * Queries the google geolocation webservice to populate a campsite either with latitude/longitude coordinates
   * when just the address is provided, or populate the address if only latitude/longitude is provided.
   * @param campsite
   * @return populated campsite
   */
  def setGeolocationData(Campsite campsite) {
    if (campsiteProvidesInputData(campsite)) {
      def uriPath = '/maps/api/geocode/json'
      def uriQuery
      def encodedAddress
      if (campsite.address) {
        encodedAddress = URLEncoder.encode(campsite.address, "UTF-8")
        uriQuery = [address: encodedAddress, sensor: "false"]
      }
      else {
        uriQuery = [latlng: campsite.latitude + "," + campsite.longitude, sensor: "false"]
      }

      try {
        def json = googleService.callGoogleWebservice(uriPath, uriQuery)
        campsite.latitude = json.results.geometry.location.lat[0]
        campsite.longitude = json.results.geometry.location.lng[0]
        campsite.address = json.results.formatted_address
        json.results.address_components[0].each {
          if (it.types.contains("country")) {
            campsite.country = it.long_name
          }
          if (it.types.contains("administrative_area_level_1")) {
            campsite.region = it.long_name
          }
          if (it.types.contains("locality")) {
            campsite.city = it.long_name
          }
        }
      }
      catch (WebserviceException ex) {
        campsite.errors.rejectValue('address', 'campsite.error.address_invalid')
      }
    }

    return campsite
  }

  private boolean campsiteProvidesInputData(Campsite campsite) {
    return campsite && (campsite?.address || (campsite.latitude && campsite.longitude))
  }

  /**
   * Returns a set of campsites which are located in the radius of the location.
   * @param loc
   * @param distance
   * @return set of campsites
   */
  def getNearbyCampsites(Location loc, double radius) {
    def nearbySites = [] as Set
    Campsite.list().each { Campsite campsite ->
      double actualDistance = calculateDistance(loc, new Location(campsite.latitude, campsite.longitude))
      if (actualDistance < radius) {
        nearbySites.add(campsite)
      }
    }

    return nearbySites
  }

  /**
   * Calculate the distance in km between to locations.
   * @param loc1
   * @param loc2
   * @return distance in km
   */
  private double calculateDistance(Location loc1, Location loc2) {
    double earthRadius = 6371;
    double dLat = Math.toRadians(loc2.latitude - loc1.latitude);
    double dLng = Math.toRadians(loc2.longitude - loc1.longitude);
    double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(Math.toRadians(loc1.latitude)) * Math.cos(Math.toRadians(loc2.latitude)) *
            Math.sin(dLng / 2) * Math.sin(dLng / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double dist = earthRadius * c;

    return dist;
  }
}
