package de.womomo

class RouteController {

  def routeService

  def index = {
    redirect(action: "route", params: params)
  }

  def route = {
    // show view
  }

  def calculateRoute = {
    def routeCommand = null
    if (params.from && params.to) {
      routeCommand = new RouteCommand(to: params.to, from: params.from, distance: params.distance.toDouble())
      routeCommand = routeService.setCampsitesOnRoute(routeCommand)
    }
    render(view: "route", model: [routeCommand: routeCommand])
  }
}

class RouteCommand {
  String from
  String to
  Double distance
  Set campsites = new HashSet()
}
