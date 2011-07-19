class BootStrap {

  def excelService

  def init = { servletContext ->
    excelService.importCampsites()
  }
  def destroy = {
  }
}
