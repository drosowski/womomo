import de.womomo.Campsite
import de.womomo.Role
import de.womomo.UserAccount
import de.womomo.UserAccountRole

class BootStrap {

    def excelService
    def campsiteService

    def init = { servletContext ->
        def adminRole = new Role(authority: "ROLE_ADMIN")
        adminRole.save()

        def daniel = new UserAccount(username: "daniel", password: "qwert", email: "daniel@test.de")
        daniel.password2 = "qwert"
        daniel.save()
        UserAccountRole.create(daniel, adminRole)

        def horst = new UserAccount(username: "horst", password: "qwert", email: "horst@test.de")
        horst.password2 = "qwert"
        horst.save()

        def campsite = new Campsite(name: "foobar", latitude: 49.075, longitude: 13.079)
        campsite = campsiteService.setGeolocationData(campsite)
        campsite.save()
        campsite.addComment(daniel, "foobar blabla")
        campsite.save()

        campsite = new Campsite(name: "foobar2", latitude: 51.844262, longitude: 7.995987)
        campsite = campsiteService.setGeolocationData(campsite)
        campsite.save()
        campsite = new Campsite(name: "barfoo", latitude: 45.715407, longitude: 1.601442)
        campsite = campsiteService.setGeolocationData(campsite)
        campsite.save()
        campsite = new Campsite(name: "barfoo2", latitude: 48.372778, longitude: 6.296111)
        campsite = campsiteService.setGeolocationData(campsite)
        campsite.save()

        excelService.importCampsites()
    }
    def destroy = {
    }
}
