<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}"/>
  <title><g:message code="campsite.overview.label"/></title>
  <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
  <g:javascript library="markerclusterer"/>
  <script type="text/javascript">
    function initMap() {
      var center = new google.maps.LatLng(51.948, 10.2652);
      var myOptions = {
        zoom: 4,
        center: center,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById("map"), myOptions);

      var markers = [];
      var pos;
      var marker;
    <g:each var="site" in="${campsites}">
      pos = new google.maps.LatLng(${site.latitude}, ${site.longitude});
      marker = new google.maps.Marker({position: pos, map: map, title:"${site.name}"});
      google.maps.event.addListener(marker, 'click', function(event) {
        document.location.href = '${createLink(action: "show", id: site.id)}';
      });
      markers.push(marker);
    </g:each>

      var markerCluster = new MarkerClusterer(map, markers);
    }

    $(document).ready(initMap);
  </script>
</head>
<body>

<content tag="sidebar">
  <div class="sidebar">
    <div class="sidebar_top"></div>
    <div class="sidebar_item">
      <g:form name="filter" action="overview">

        <h3><g:message code="campsite.filter.form.label" default="Filter display"/></h3>

        <div class="sidebar_form_settings">
          <p><span><g:message code="campsite.filter.country.label" default="Country"/></span>
            <select name="country" id="country" onchange="document.forms['filter'].submit();">
              <option value=""><g:message code="campsite.country.all" default="All"/></option>
              <g:each var="country" in="${countries}">
                <option <g:if test="${filter?.country == country}">selected="selected"</g:if>>${country}</option>
              </g:each>
            </select>
          </p>

          <p id="regionSelect"><g:render template="regionSelect"/></p>
        </div>
      </g:form>
    </div>
    <div class="sidebar_base"></div>
  </div>

  <div class="sidebar">
    <div class="sidebar_top"></div>
    <div class="sidebar_item">
      <g:form action="search">
        <h3><g:message code="campsite.search.form.label" default="Search"/></h3>

        <div class="sidebar_form_settings">
          <p><span><g:message code="campsite.search.query.label" default="Query"/></span><g:textField name="query" value="${search?.query}" class="text"/></p>

          <p><span><g:message code="campsite.search.periphery.label" default="Periphery of"/></span><g:textField name="periphery" value="${search?.radius}" class="text"/></p>

          <p><span><g:message code="campsite.search.radius.label" default="Radius"/></span>
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

          <p><span>&nbsp;</span><input class="submit" type="submit" name="name" value="${message(code: 'button.search.label', default: 'Search')}"/></p>
        </div>
      </g:form>
    </div>
    <div class="sidebar_base"></div>
  </div>
</content>


<content tag="body">
  <h1><g:message code="campsite.overview.label"/></h1>
  <div id="map" style="width: 600px; height: 400px"></div>
</content>

</body>
</html>
