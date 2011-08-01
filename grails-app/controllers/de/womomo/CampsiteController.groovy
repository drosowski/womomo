package de.womomo

import org.grails.comments.Comment
import org.grails.comments.CommentLink
import grails.util.GrailsNameUtils
import org.grails.comments.CommentException
import org.grails.rateable.RatingException
import org.grails.rateable.Rating
import org.grails.rateable.RatingLink

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
    def countries = getCountries(campsites)


    if (params.country) {
      campsites = campsites.findAll { it.country == params.country }
      regions = getRegionsForCountry(params.country)
    }
    if (params.region && regions.contains(params.region)) {
      campsites = campsites.findAll { it.region == params.region }
    }

    render(view: "overview", model: [campsites: campsites, countries: countries, regions: regions, filter: [country: params.country, region: params.region]])
  }

  def updateRegions = {
    if (params.country) {
      def regions = getRegionsForCountry(params.country)
      render(template: "regionSelect", model: [regions: regions])
    }
  }

  private Set getCountries(campsites) {
    def countries = [] as Set
    campsites.each {
      if (it.country)
        countries.add(it.country)
    }
    return countries
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

  def search = {
    if (params.query || params.periphery) {
      def nearbyCampsites = []
      if (params.periphery) {
        def campsite = new Campsite(address: params.periphery)
        campsite = campsiteService.setGeolocationData(campsite)
        nearbyCampsites = campsiteService.getNearbyCampsites(new Location(campsite.latitude, campsite.longitude), params.radius.toDouble())
      }
      if (params.query) {
        def searchResult = Campsite.search(params.query)
        campsites = searchResult.results
        if (nearbyCampsites) {
          nearbyCampsites = nearbyCampsites.intersect(campsites)
        }
      }
      render(view: 'overview', model: [campsites: nearbyCampsites, countries: getCountries(Campsite.list())])
    }
    else {
      render(action: "overview", model: [countries: getCountries(Campsite.list())])
    }
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
    def poster = evaluatePoster()
    def commentLink
    try {
      if (params['comment'] instanceof Map) {
        Comment.withTransaction { status ->
          def comment = new Comment(params['comment'])
          comment.posterId = poster.id
          comment.posterClass = poster.class.name
          commentLink = new CommentLink(params['commentLink'])
          commentLink.type = GrailsNameUtils.getPropertyName(commentLink.type)

          if (!comment.save()) {
            status.setRollbackOnly()
          }
          else {
            commentLink.comment = comment
            if (!commentLink.save()) status.setRollbackOnly()
          }
        }
      }
    }
    catch (Exception e) {
      log.error "Error posting comment: ${e.message}"
    }

    def comments = CommentLink.withCriteria {
      projections {
        property "comment"
      }
      eq 'type', commentLink.type
      eq 'commentRef', commentLink.commentRef
      cache true
    }
    if (request.xhr || params.async) {
      render template: "comment",
              collection: comments,
              var: "comment"
    }
    else {
      redirect url: params.commentPageURI
    }
  }

  def evaluatePoster() {
    def evaluator = grailsApplication.config.grails.commentable.poster.evaluator
    def poster
    if (evaluator instanceof Closure) {
      evaluator.delegate = this
      evaluator.resolveStrategy = Closure.DELEGATE_ONLY
      poster = evaluator.call()
    }

    if (!poster) {
      throw new CommentException("No [grails.commentable.poster.evaluator] setting defined or the evaluator doesn't evaluate to an entity. Please define the evaluator correctly in grails-app/conf/Config.groovy or ensure commenting is secured via your security rules")
    }
    if (!poster.id) {
      throw new CommentException("The evaluated Comment poster is not a persistent instance.")
    }
    return poster
  }

  def rate = {
    def rater = evaluateRater()

    // for an existing rating, update it
    def rating = RatingLink.createCriteria().get {
      createAlias("rating", "r")
      projections {
        property "rating"
      }
      eq "ratingRef", params.id.toLong()
      eq "type", params.type
      eq "r.raterId", rater.id.toLong()
      cache true
    }
    if (rating) {
      rating.stars = params.rating.toDouble()
      assert rating.save()
    }
    // create a new one otherwise
    else {
      // create Rating
      rating = new Rating(stars: params.rating, raterId: rater.id, raterClass: rater.class.name)
      assert rating.save()
      def link = new RatingLink(rating: rating, ratingRef: params.id, type: params.type)
      assert link.save()
    }

    def allRatings = RatingLink.withCriteria {
      projections {
        property 'rating'
      }
      eq "ratingRef", params.id.toLong()
      eq "type", params.type
      cache true
    }
    def avg = allRatings.size() ? allRatings*.stars.sum() / allRatings.size() : 0

    render "${avg},${allRatings.size()}"
  }

  def evaluateRater() {
    def evaluator = grailsApplication.config.grails.rateable.rater.evaluator
    def rater
    if (evaluator instanceof Closure) {
      evaluator.delegate = this
      evaluator.resolveStrategy = Closure.DELEGATE_ONLY
      rater = evaluator.call()
    }

    if (!rater) {
      throw new RatingException("No [grails.rateable.rater.evaluator] setting defined or the evaluator doesn't evaluate to an entity. Please define the evaluator correctly in grails-app/conf/Config.groovy or ensure rating is secured via your security rules")
    }
    if (!rater.id) {
      throw new RatingException("The evaluated Rating rater is not a persistent instance.")
    }
    return rater
  }
}
