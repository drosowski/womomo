package de.womomo

class RouteService {

  def grailsApplication

  static transactional = true

  def calculateRoute(RouteCommand routeCommand) {
    def config = grailsApplication.config
    if (routeCommand?.from && routeCommand?.to) {
      routeCommand.from = URLEncoder.encode(routeCommand.from, "UTF-8")
      routeCommand.to = URLEncoder.encode(routeCommand.to, "UTF-8")
      def result = null
      withHttp(uri: "http://maps.google.de", proxy: [host: config.proxy.host, port: config.proxy.port, scheme: "http"]) {
        result = get(path: '/maps/api/directions/json', query:
        [
                origin: routeCommand.from,
                destination: routeCommand.to,
                sensor: "false"
        ])
      }
      if (result && result.status == "OK") {
        result.routes.each { route ->
          if (route?.overview_polyline) {
            def points = PolylineDecoder.decodePoly(route.overview_polyline.points.toString())
            points.each { Location loc ->
              def campsites = getNearbyCampsites(loc, routeCommand.distance)
              routeCommand.campsites.addAll(campsites)
            }
          }
        }
      }
    }

    return routeCommand
  }

  private Set getNearbyCampsites(Location loc, double distance) {
    def nearbySites = [] as Set
    Campsite.list().each { Campsite campsite ->
      double actualDistance = calculateDistance(loc.latitude, loc.longitude, campsite.latitude, campsite.longitude)
      if (actualDistance < distance) {
        nearbySites.add(campsite)
      }
    }

    return nearbySites
  }

  public double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double earthRadius = 6371;
    double dLat = Math.toRadians(lat2 - lat1);
    double dLng = Math.toRadians(lng2 - lng1);
    double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
            Math.sin(dLng / 2) * Math.sin(dLng / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double dist = earthRadius * c;

    return dist;
  }

}
