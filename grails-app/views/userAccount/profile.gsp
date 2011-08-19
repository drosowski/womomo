<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title><g:message code="userAccount.profile.label" args='["${user.username}"]'/></title>
  <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
  <script type="text/javascript">
    function initMap() {
      var center = new google.maps.LatLng(51.948, 10.2652);
      var myOptions = {
        zoom: 4,
        center: center,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById("map"), myOptions);

      var pos;
      var marker;
    <g:each var="site" in="${campsites}">
      pos = new google.maps.LatLng(${site.latitude}, ${site.longitude});
      marker = new google.maps.Marker({position: pos, map: map, title:"${site.name}"});
      google.maps.event.addListener(marker, 'click', function(event) {
        document.location.href = '${createLink(controller: "campsite", action: "show", id: site.id)}';
      });
    </g:each>
    }
    $(document).ready(initMap);
  </script>
</head>
<body>
<content tag="sidebar"></content>

<content tag="body">

  <h1><g:message code="userAccount.profile.label" args='["${user.username}"]'/></h1>

  <g:hasErrors bean="${user}">
    <div class="errors">
      <g:renderErrors bean="${user}" as="list"/>
    </div>
  </g:hasErrors>

  <g:set var="userId" value="${sec.loggedInUserInfo(field: 'id')}"/>
  <g:if test="${user.id == userId?.toLong()}">
    <h2><g:message code="userAccount.profile.update.label" default="Update your data"/></h2>
    <g:form method="post">
      <div class="form_settings">
        <g:hiddenField name="id" value="${user?.id}"/>
        <g:hiddenField name="version" value="${user?.version}"/>

        <p><span><g:message code="userAccount.email.label" default="E-Mail"/></span><g:textField name="email" value="${user?.email}"/></p>

        <p><span><g:message code="userAccount.password.label" default="Password"/></span><g:passwordField name="password"/></p>

        <p><span><g:message code="register.password2.label" default="Repeat password"/></span><g:textField name="password2"/></p>

        <br/>
        <p class="buttons"><g:actionSubmit class="submit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"/></p>
      </div>
    </g:form>
  </g:if>

  <h2><g:message code="userAccount.profile.places.label" default="Visited campsites"/></h2>
  <p><g:message code="userAccount.profile.places.rate_to_show.label"/></p>
  <div id="map" style="width: 600px; height: 400px"></div>
</content>

</body>
</html>
