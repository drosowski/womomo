package de.womomo

import grails.test.GrailsUnitTestCase

class CampsiteServiceIntegrationTests extends GrailsUnitTestCase {

  def campsiteService

  protected void setUp() {
    super.setUp()
  }

  protected void tearDown() {
    super.tearDown()
  }

  void testSetGeolocationData() {
    def campsite = new Campsite(name: "foobar", address: "Niederwall, Bielefeld")
    campsite = campsiteService.setGeolocationData(campsite)
    assertNotNull(campsite.address)
    assertNotNull(campsite.country)
    assertNotNull(campsite.region)
    assertNotNull(campsite.latitude)
    assertNotNull(campsite.longitude)
  }
}
