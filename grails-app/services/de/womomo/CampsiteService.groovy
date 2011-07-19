package de.womomo

class CampsiteService {

  static transactional = false

  def getGeolocationData(Campsite campsite) {
    if (campsite?.address) {
      def encodedAddress = URLEncoder.encode(campsite.address, "UTF-8")
      def result = null
      withHttp(uri: "http://maps.google.com") {
        result = get(path: '/maps/api/geocode/json', query: [address: encodedAddress, sensor: "false"])
      }
      if (result && result.status == "OK") {
        campsite.latitude = result.results.geometry.location.lat
        campsite.longitude = result.results.geometry.location.lng
      }
    }
    return campsite
  }
}
