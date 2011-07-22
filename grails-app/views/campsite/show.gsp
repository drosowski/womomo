<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}"/>
  <title><g:message code="default.show.label" args="[entityName]"/></title>
  <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
  <script type="text/javascript">
    function initMap() {
      var center = new google.maps.LatLng(${campsiteInstance.latitude}, ${campsiteInstance.longitude});
      var myOptions = {
        zoom: 13,
        center: center,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById("map"), myOptions);
      var marker = new google.maps.Marker({
        position: center,
        map: map,
        title:"${campsiteInstance.name}"
      });
    }
    $(document).ready(initMap);
  </script>
</head>
<body>
<div class="body">

  <h1>${campsiteInstance.name}</h1>

  <div class="span-10">
    <fieldset>
      <p>
        <g:message code="campsite.id.label" default="Id"/><br/>
        ${fieldValue(bean: campsiteInstance, field: "id")}
      </p>

      <p>
        <g:message code="campsite.address.label" default="Address"/><br/>
        ${fieldValue(bean: campsiteInstance, field: "address")}
      </p>

      <p>
        <g:message code="campsite.country.label" default="Country"/><br/>
        ${fieldValue(bean: campsiteInstance, field: "country")}
      </p>

      <p>
        <g:message code="campsite.region.label" default="Region"/><br/>
        ${fieldValue(bean: campsiteInstance, field: "region")}
      </p>

      <p>
        <g:message code="campsite.city.label" default="City"/><br/>
        ${fieldValue(bean: campsiteInstance, field: "city")}
      </p>

      <p>
        <g:message code="campsite.latitude.label" default="Latitude"/><br/>
        ${fieldValue(bean: campsiteInstance, field: "latitude")}
      </p>

      <p>
        <g:message code="campsite.longitude.label" default="Longitude"/><br/>
        ${fieldValue(bean: campsiteInstance, field: "longitude")}
      </p>
    </fieldset>

    <div id="comments">
      <g:message code="campsite.comments.label" default="Comments"/><br/>
      <table>
        <comments:each bean="${campsiteInstance}">
          <tr>
            <td valign="top" class="name">${comment.poster.username}</td>
            <td valign="top" class="value"><g:textArea name="comment" value="${comment.body}" disabled="disabled"/></td>
          </tr>
        </comments:each>
      </table>

      <sec:ifLoggedIn>
        <g:form>
          <g:hiddenField name="id" value="${campsiteInstance?.id}"/>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="comment"><g:message code="campsite.newComment.label" default="New comment"/></label>
            </td>
            <td valign="top" class="value">
              <g:textArea name="comment"/><br/>
              <span class="button"><g:actionSubmit action="addComment" value="${message(code: 'button.addComment.label', default: 'Add comment')}"/></span>
            </td>
          </tr>
        </g:form>
      </sec:ifLoggedIn>
    </div>
  </div>

  <div class="span-14 last">
    <div id="map" style="width: 500px; height: 300px"></div>
  </div>

</div>
</body>
</html>
