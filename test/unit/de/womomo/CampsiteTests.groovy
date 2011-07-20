package de.womomo

import grails.test.*

class CampsiteTests extends GrailsUnitTestCase {

  def savedCampsite

  protected void setUp() {
    super.setUp()
    savedCampsite = new Campsite(name: "foobar")
  }

  protected void tearDown() {
    super.tearDown()
  }

  void testConstraints() {
    mockForConstraintsTests(Campsite, [savedCampsite])

    Campsite campsite = new Campsite()
    assertFalse(campsite.validate())
    assertEquals("nullable", campsite.errors.name)

    campsite = new Campsite(name: " ", address: " ", country: " ", city: " ", region: " ")
    assertFalse(campsite.validate())
    assertEquals("blank", campsite.errors.name)
    assertEquals("blank", campsite.errors.address)
    assertEquals("blank", campsite.errors.country)
    assertEquals("blank", campsite.errors.city)
    assertEquals("blank", campsite.errors.region)

    campsite = new Campsite(name: "foobar")
    assertFalse(campsite.validate())
    assertEquals("unique", campsite.errors.name)

    assertTrue(savedCampsite.validate())
  }
}