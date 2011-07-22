package de.womomo

import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.JSON
import static groovyx.net.http.Method.GET

class GoogleService {

  static transactional = true

  def callGoogleWebservice(String uriPath, Map uriQuery) throws WebserviceException {
    def result = ""

    def http = new HTTPBuilder("http://maps.google.de")
    def proxyHost = System.getProperty("http.proxyHost")
    def proxyPort = System.getProperty("http.proxyPort")
    if (proxyHost) {
      http.setProxy(proxyHost, proxyPort?.toInteger(), "http")
    }

    http.request(GET, JSON) {
      uri.path = uriPath
      uri.query = uriQuery

      response.success = { resp, json ->
        result = json
      }

      response.failure = { resp ->
        def msg = "${resp.status}: ${resp.statusLine.reasonPhrase}"
        log.error(msg)
        throw new WebserviceException(msg)
      }
    }

    return result
  }
}
