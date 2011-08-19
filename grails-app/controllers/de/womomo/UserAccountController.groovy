package de.womomo

import org.grails.rateable.Rating
import org.grails.rateable.RatingLink

class UserAccountController {

  def profile = {
    withUserAccount { UserAccount user ->
      def ratings = Rating.findAllByRaterId(user.id)
      def ratingLinks = ratings.collect { RatingLink.findByRating(it) }
      def campsites = ratingLinks.collect { Campsite.get(it.ratingRef) }
      return [user: user, campsites: campsites]
    }
  }

  private def withUserAccount(id = "id", Closure c) {
    def user = UserAccount.get(params[id])
    if (user) {
      c.call(user)
    } else {
      flash.message = "Das Benutzerkonto konnte nicht gefunden werden."
      redirect(uri: "/")
    }
  }
}
