<%@ page import="grails.util.GrailsNameUtils" %>
<h3><g:message code="campsite.rating.title"/></h3>
<div class="ratings">
  <form id="form_1" action="#" method="post">
    <g:message code="campsite.rating.label"/>: <span id="stars-cap"></span>
    <div id="stars-wrapper">
      <g:set var="average" value="${campsiteInstance.averageRating ? BigDecimal.valueOf(campsiteInstance.averageRating)?.setScale(0, BigDecimal.ROUND_HALF_UP) : 0}"/>
      <input type="radio" name="newrate" value="1" title="${g.message(code: "campsite.rating.1")}" <g:if test="${average == 1}">checked="checked"</g:if>>
      <input type="radio" name="newrate" value="2" title="${g.message(code: "campsite.rating.2")}" <g:if test="${average == 2}">checked="checked"</g:if>>
      <input type="radio" name="newrate" value="3" title="${g.message(code: "campsite.rating.3")}" <g:if test="${average == 3}">checked="checked"</g:if>>
      <input type="radio" name="newrate" value="4" title="${g.message(code: "campsite.rating.4")}" <g:if test="${average == 4}">checked="checked"</g:if>>
      <input type="radio" name="newrate" value="5" title="${g.message(code: "campsite.rating.5")}" <g:if test="${average == 5}">checked="checked"</g:if>>
    </div>
  </form>
  <p><g:message code="campsite.average_rating" args="${[campsiteInstance.totalRatings]}"/></p>
</div>

<sec:ifLoggedIn>
  <br/><sub><g:message code="campsite.rate.help"/></sub>
  <script type="text/javascript">
    $("#stars-wrapper").stars({
      captionEl: $("#stars-cap"),
      callback: function(ui, type, value) {
      ${remoteFunction(action: 'rate', update: 'rating_sidebar', id: campsiteInstance.id, params:'\'rating=\' + value + \'&type=' + GrailsNameUtils.getPropertyName(campsiteInstance.class) + '\'')}
      }
    });
  </script>
</sec:ifLoggedIn>

<sec:ifNotLoggedIn>
  <br/><sub><g:message code="campsite.rate.login"/></sub>
  <script type="text/javascript">
    $("#stars-wrapper").stars({
      captionEl: $("#stars-cap"),
      disabled: true
    });
  </script>
</sec:ifNotLoggedIn>
