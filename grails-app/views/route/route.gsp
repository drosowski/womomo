<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title><g:message code="default.create.label" args="['Route']"/></title>
  <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
  <script type="text/javascript">
    function initMap() {
      var berlin = new google.maps.LatLng(51.948, 10.2652);
      var myOptions = {
        zoom: 4,
        center: berlin,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById("map"), myOptions);


    <g:if test="${routeCommand}">
      directionsDisplay = new google.maps.DirectionsRenderer();
      directionsDisplay.setMap(map);
      var request = {
        origin:"${routeCommand.from}",
        destination:"${routeCommand.to}",
        travelMode: google.maps.DirectionsTravelMode.DRIVING
      };
      var directionsService = new google.maps.DirectionsService();
      directionsService.route(request, function(result, status) {
        if (status == google.maps.DirectionsStatus.OK) {
          directionsDisplay.setDirections(result);
        }
      });

      var marker;
    <g:each var="site" in="${routeCommand.campsites}">
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(${site.latitude}, ${site.longitude}),
        map: map,
        title:"${site.name}"
      });
      google.maps.event.addListener(marker, 'click', function(event) {
        document.location.href = '${createLink(controller: 'campsite', action: "show", id: site.id)}';
      });
    </g:each>
    </g:if>
    }
    $(document).ready(initMap);
  </script>

</head>
<body>
<content tag="sidebar"></content>

<content tag="body">

  <h1><g:message code="route.calculate.label"/></h1>

  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>

  <g:form action="calculateRoute">
    <div class="form_settings">

      <p><span><g:message code="route.from.label"/></span><g:textField name="from" class="text"/></p>

      <p><span><g:message code="route.to.label"/></span><g:textField name="to" class="text"/></p>

      <p><span><g:message code="route.radius.label"/></span>
        <select name="radius" id="radius">
          <option>5</option>
          <option>10</option>
          <option>15</option>
          <option>20</option>
          <option>25</option>
          <option>30</option>
          <option>35</option>
          <option>40</option>
          <option>45</option>
          <option>50</option>
          <option>60</option>
          <option>70</option>
          <option>80</option>
          <option>90</option>
          <option>100</option>
        </select> km
      </p>

      <p class="buttons"><g:submitButton name="calculate" class="submit" value="${message(code: 'route.button.calculate.label', default: 'Calculate')}"/></p>
    </div>
  </g:form>
  <br/>

  <div id="map" style="width: 500px; height: 300px"></div>
</content>
</body>
</html>
