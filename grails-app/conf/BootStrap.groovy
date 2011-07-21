import de.womomo.Campsite
import de.womomo.UserAccount

class BootStrap {

  def excelService
  def springSecurityService

  def init = { servletContext ->
    def daniel = new UserAccount(username: "daniel", password: springSecurityService.encodePassword("qwert"))
    daniel.save()

    def campsite = new Campsite(name: "foobar", country: "Deutschland", region: "Bayern", latitude: 49.075, longitude: 13.079)
    campsite.save()
    campsite.addComment(daniel, "foobar blabla")
    campsite.save()

    new Campsite(name: "foobar2", country: "Deutschland", region: "Nordrhein-Westfalen", latitude: 51.844262, longitude: 7.995987).save()
    new Campsite(name: "barfoo", country: "Frankreich", region: "Limousin", latitude: 45.715407, longitude: 1.601442).save()
    new Campsite(name: "barfoo2", country: "Frankreich", region: "Lothringen", latitude: 48.372778, longitude: 6.296111).save()

    excelService.importCampsites()
  }
  def destroy = {
  }
}
