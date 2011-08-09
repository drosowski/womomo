<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}"/>
  <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>
<body>
<content tag="sidebar"></content>

<content tag="body">

  <h1><g:message code="default.create.label" args="[entityName]"/></h1>

  <g:hasErrors bean="${campsiteInstance}">
    <div class="error">
      <g:renderErrors bean="${campsiteInstance}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="save">
    <div class="form_settings">
      <p><span><g:message code="campsite.name.label" default="Name"/></span><g:textField name="name" value="${campsiteInstance?.name}" class="text"/></p>

      <p><span><g:message code="campsite.address.label" default="Address"/></span><g:textField name="address" value="${campsiteInstance?.address}" class="text"/></p>

      <p><span><g:message code="campsite.latitude.label" default="Latitude"/></span><g:textField name="latitude" value="${campsiteInstance?.latitude}" class="text"/></p>

      <p><span><g:message code="campsite.longitude.label" default="Longitude"/></span><g:textField name="longitude" value="${campsiteInstance?.longitude}" class="text"/></p>

      <br/>
      <p class="buttons"><input class="submit" type="submit" name="create" value="${message(code: 'default.button.create.label', default: 'Create')}"/></p>
    </div>
  </g:form>
</content>

</body>
</html>
