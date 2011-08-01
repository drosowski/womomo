<%@ page import="grails.util.GrailsNameUtils" %>
<h3><g:message code="campsite.rating.title"/></h3>
<div class="ratings">
  <form id="form_1" action="#" method="post">
    <g:message code="campsite.rating.label"/>: <span id="stars-cap"></span>
    <div id="stars-wrapper">
      <input type="radio" name="newrate" value="1" title="${g.message(code: "campsite.rating.1")}">
      <input type="radio" name="newrate" value="2" title="${g.message(code: "campsite.rating.2")}">
      <input type="radio" name="newrate" value="3" title="${g.message(code: "campsite.rating.3")}">
      <input type="radio" name="newrate" value="4" title="${g.message(code: "campsite.rating.4")}">
      <input type="radio" name="newrate" value="5" title="${g.message(code: "campsite.rating.5")}">
      <input type="radio" name="newrate" value="6" title="${g.message(code: "campsite.rating.6")}">
      <input type="radio" name="newrate" value="7" title="${g.message(code: "campsite.rating.7")}">
      <input type="radio" name="newrate" value="8" title="${g.message(code: "campsite.rating.8")}" checked="checked">
      <input type="radio" name="newrate" value="9" title="${g.message(code: "campsite.rating.9")}">
      <input type="radio" name="newrate" value="10" title="${g.message(code: "campsite.rating.10")}">
    </div>
  </form>
</div>

<sec:ifLoggedIn>
  <br/><sub><g:message code="campsite.rate.help"/></sub>
  <script type="text/javascript">
    $("#stars-wrapper").stars({
      split: 2,
      captionEl: $("#stars-cap"),
      callback: function(ui, type, value) {
      ${remoteFunction(action: 'rate', id: campsiteInstance.id, params:'\'rating=\' + value + \'&type=' + GrailsNameUtils.getPropertyName(campsiteInstance.class) + '\'')}
      }
    });
  </script>
</sec:ifLoggedIn>

<sec:ifNotLoggedIn>
  <br/><sub><g:message code="campsite.rate.login"/></sub>
  <script type="text/javascript">
    $("#stars-wrapper").stars({
      split: 2,
      captionEl: $("#stars-cap"),
      disabled: true
    });
  </script>
</sec:ifNotLoggedIn>
