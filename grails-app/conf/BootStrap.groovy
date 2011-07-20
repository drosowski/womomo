import de.womomo.Campsite
import de.womomo.UserAccount

class BootStrap {

  def excelService
  def springSecurityService

  def init = { servletContext ->
    def daniel = new UserAccount(username: "daniel", password: springSecurityService.encodePassword("qwert"))
    daniel.save()
    def foobar = new Campsite(name: "Foobar", country: "Deutschland", latitude: 49.075, longitude: 13.079)
    foobar.save()
    foobar.addComment(daniel, "foobar blabla")
    foobar.save()
    excelService.importCampsites()
  }
  def destroy = {
  }
}
