package de.womomo

class RouteService {

  def googleService
  def campsiteService

  static transactional = false

  /**
   * Find all campsites which are located in the given radius of a route.
   * This service uses the google directions api to calculate a route between two addresses.
   * @param routeCommand
   * @return routeCommand with the campsites near the route
   */
  def setCampsitesOnRoute(RouteCommand routeCommand) {
    if (routeCommand?.from && routeCommand?.to) {
      routeCommand.from = URLEncoder.encode(routeCommand.from, "UTF-8")
      routeCommand.to = URLEncoder.encode(routeCommand.to, "UTF-8")

      def uriPath = '/maps/api/directions/json'
      def uriQuery = [
              origin: routeCommand.from,
              destination: routeCommand.to,
              sensor: "false"
      ]

      try {
        def json = googleService.callGoogleWebservice(uriPath, uriQuery)
        def route = json.routes[0]
        if (route?.overview_polyline) {
          def points = PolylineDecoder.decodePoly(route.overview_polyline.points.toString())
          points.each { Location loc ->
            def campsites = campsiteService.getNearbyCampsites(loc, routeCommand.radius)
            routeCommand.campsites.addAll(campsites)
          }
        }
      }
      catch (WebserviceException ex) {
        routeCommand.rejectValue('from', 'route.error.route_invalid')
      }
    }

    return routeCommand
  }

}
