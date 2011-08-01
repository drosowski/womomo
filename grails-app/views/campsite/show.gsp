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
<content tag="sidebar"></content>

<content tag="body">

  <h1><g:message code="campsite.label" default="Campsite"/></h1>
  <h2>${campsiteInstance.name}</h2>

  <div id="map" style="width: 600px; height: 400px"></div>
  <br/>

  <h2><g:message code="campsite.details.label" default="Campsite details"/></h2>
  <table style="width:100%; border-spacing:0;">
    <tr>
      <td><g:message code="campsite.name.label" default="Name"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "name")}</td>
    </tr>

    <tr>
      <td><g:message code="campsite.id.label" default="Id"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "id")}</td>
    </tr>

    <tr>
      <td><g:message code="campsite.address.label" default="Address"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "address")}</td>
    </tr>

    <tr>
      <td><g:message code="campsite.country.label" default="Country"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "country")}</td>
    </tr>

    <tr>
      <td><g:message code="campsite.region.label" default="Region"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "region")}</td>
    </tr>

    <tr>
      <td><g:message code="campsite.city.label" default="City"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "city")}</td>
    </tr>

    <tr>
      <td><g:message code="campsite.latitude.label" default="Latitude"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "latitude")}</td>
    </tr>

    <tr>
      <td><g:message code="campsite.longitude.label" default="Longitude"/></td>
      <td>${fieldValue(bean: campsiteInstance, field: "longitude")}</td>
    </tr>
  </table>

  <h2><g:message code="campsite.comments.label" default="Comments"/></h2>
  <g:render template="comments" model="['commentable': campsiteInstance]"/>
</content>

</body>
</html>
