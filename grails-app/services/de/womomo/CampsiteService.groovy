package de.womomo

import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.JSON
import static groovyx.net.http.Method.GET

class CampsiteService {

  static transactional = false

  def setGeolocationData(Campsite campsite) {
    if (campsite?.address) {
      def encodedAddress = URLEncoder.encode(campsite.address, "UTF-8")
      def result = null

      def http = new HTTPBuilder("http://maps.google.de")
      def proxyHost = System.getProperty("http.proxyHost")
      def proxyPort = System.getProperty("http.proxyPort")
      http.setProxy(proxyHost, proxyPort?.toInteger(), "http")
      http.request(GET, JSON) {
        uri.path = '/maps/api/geocode/json'
        uri.query = [address: encodedAddress, sensor: "false"]

        response.success = { resp, json ->
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
          }
        }

        response.failure = { resp ->
          log.error "Unexpected error: ${resp.status}: ${resp.statusLine.reasonPhrase}"
        }
      }
    }

    return campsite
  }
}
