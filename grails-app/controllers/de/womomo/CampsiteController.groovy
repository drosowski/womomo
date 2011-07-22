package de.womomo

class CampsiteController {

  def campsiteService
  def springSecurityService

  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def index = {
    redirect(action: "overview", params: params)
  }

  def overview = {
    def campsites = Campsite.list()

    def regions = [] as Set
    def countries = [] as Set
    campsites.each {
      if (it.country)
        countries.add(it.country)
    }

    if (params.country) {
      campsites = campsites.findAll { it.country == params.country }
      regions = getRegionsForCountry(params.country)
    }
    if (params.region) {
      campsites = campsites.findAll { it.region == params.region }
    }
    if (params.query) {
      def searchResult = Campsite.search(params.query)
      campsites = searchResult.results
    }
    render(view: "overview", model: [campsites: campsites, countries: countries, regions: regions, search: [country: params.country, region: params.region]])
  }

  def updateRegions = {
    if (params.country) {
      def regions = getRegionsForCountry(params.country)
      render(template: "regionSelect", model: [regions: regions])
    }
  }

  private Set getRegionsForCountry(String country) {
    def campsites = Campsite.findAllByCountry(params.country)
    def regions = [] as Set
    campsites.each {
      if (it.region)
        regions.add(it.region)
    }
    return regions
  }

  def list = {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [campsiteInstanceList: Campsite.list(params), campsiteInstanceTotal: Campsite.count()]
  }

  def create = {
    def campsiteInstance = new Campsite()
    campsiteInstance.properties = params
    return [campsiteInstance: campsiteInstance]
  }

  def save = {
    def campsiteInstance = new Campsite(params)
    campsiteInstance = campsiteService.setGeolocationData(campsiteInstance)
    if (campsiteInstance.save(flush: true)) {
      flash.message = "${message(code: 'default.created.message', args: [message(code: 'campsite.label', default: 'Campsite'), campsiteInstance.id])}"
      redirect(action: "show", id: campsiteInstance.id)
    }
    else {
      render(view: "create", model: [campsiteInstance: campsiteInstance])
    }
  }

  def show = {
    def campsiteInstance = Campsite.get(params.id)
    if (!campsiteInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'campsite.label', default: 'Campsite'), params.id])}"
      redirect(action: "list")
    }
    else {
      [campsiteInstance: campsiteInstance]
    }
  }

  def edit = {
    def campsiteInstance = Campsite.get(params.id)
    if (!campsiteInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'campsite.label', default: 'Campsite'), params.id])}"
      redirect(action: "list")
    }
    else {
      return [campsiteInstance: campsiteInstance]
    }
  }

  def update = {
    def campsiteInstance = Campsite.get(params.id)
    if (campsiteInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (campsiteInstance.version > version) {

          campsiteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'campsite.label', default: 'Campsite')] as Object[], "Another user has updated this Campsite while you were editing")
          render(view: "edit", model: [campsiteInstance: campsiteInstance])
          return
        }
      }
      campsiteInstance.properties = params
      if (!campsiteInstance.hasErrors() && campsiteInstance.save(flush: true)) {
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'campsite.label', default: 'Campsite'), campsiteInstance.id])}"
        redirect(action: "show", id: campsiteInstance.id)
      }
      else {
        render(view: "edit", model: [campsiteInstance: campsiteInstance])
      }
    }
    else {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'campsite.label', default: 'Campsite'), params.id])}"
      redirect(action: "list")
    }
  }

  def delete = {
    def campsiteInstance = Campsite.get(params.id)
    if (campsiteInstance) {
      try {
        campsiteInstance.delete(flush: true)
        flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'campsite.label', default: 'Campsite'), params.id])}"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'campsite.label', default: 'Campsite'), params.id])}"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'campsite.label', default: 'Campsite'), params.id])}"
      redirect(action: "list")
    }
  }

  def addComment = {
    def campsiteInstance = Campsite.get(params.id)
    if (campsiteInstance) {
      def user = springSecurityService.currentUser
      campsiteInstance.addComment(user, params.comment)
      if (campsiteInstance.save(flush: true)) {
        flash.message = "${message(code: 'campsite.comment.created')}"
        redirect(action: "show", id: campsiteInstance.id)
      }
      else {
        flash.message = "${message(code: 'campsite.comment.error')}"
        redirect(view: "show", id: params.id)
      }
    }
    else {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'campsite.label', default: 'Campsite'), params.id])}"
      redirect(action: "list")
    }
  }
}
