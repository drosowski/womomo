<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}"/>
  <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>
<body>
<content tag="sidebar"></content>

<content tag="body">

  <h1><g:message code="default.edit.label" args="[entityName]"/></h1>

  <g:hasErrors bean="${campsiteInstance}">
    <div class="errors">
      <g:renderErrors bean="${campsiteInstance}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form method="post">
    <div class="form_settings">
      <g:hiddenField name="id" value="${campsiteInstance?.id}"/>
      <g:hiddenField name="version" value="${campsiteInstance?.version}"/>

      <p><span><g:message code="campsite.address.label" default="Address"/></span><g:textField name="address" value="${campsiteInstance?.address}"/></p>

      <p><span><g:message code="campsite.latitude.label" default="Latitude"/></span><g:textField name="latitude" value="${campsiteInstance?.latitude}"/></p>

      <p><span><g:message code="campsite.longitude.label" default="Longitude"/></span><g:textField name="longitude" value="${campsiteInstance?.longitude}"/></p>

      <p><span><g:message code="campsite.name.label" default="Name"/></span><g:textField name="name" value="${campsiteInstance?.name}"/></p>

      <br/>
      <p class="buttons"><g:actionSubmit class="submit" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"/>&nbsp;<g:actionSubmit class="submit" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></p>
    </div>
  </g:form>
</content>

</body>
</html>
