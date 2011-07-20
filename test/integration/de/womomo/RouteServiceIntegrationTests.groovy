package de.womomo

class RouteServiceIntegrationTests extends GroovyTestCase {

  def routeService

  protected void setUp() {
    super.setUp()
  }

  protected void tearDown() {
    super.tearDown()
  }

  void testCalculateRoute() {
    RouteCommand routeCommand = new RouteCommand(from: "bielefeld", to: "hannover", distance: 5)
    routeCommand = routeService.setCampsitesOnRoute(routeCommand)
  }
}
