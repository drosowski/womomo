<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}"/>
  <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>
<body>
<div class="body">

  <h1><g:message code="default.create.label" args="[entityName]"/></h1>

  <div class="span-24">
    <g:if test="${flash.message}">
      <div class="success">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${campsiteInstance}">
      <div class="error">
        <g:renderErrors bean="${campsiteInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save">
      <fieldset>
        <p>
          <label for="name"><g:message code="campsite.name.label" default="Name"/></label><br/>
          <g:textField name="name" value="${campsiteInstance?.name}" class="text"/>
        </p>

        <p>
          <label for="address"><g:message code="campsite.address.label" default="Address"/></label><br/>
          <g:textField name="address" value="${campsiteInstance?.address}" class="text"/>
        </p>

        <p>
          <label for="latitude"><g:message code="campsite.latitude.label" default="Latitude"/></label><br/>
          <g:textField name="latitude" value="${campsiteInstance?.latitude}" class="text"/>
        </p>

        <p>
          <label for="longitude"><g:message code="campsite.longitude.label" default="Longitude"/></label><br/>
          <g:textField name="longitude" value="${campsiteInstance?.longitude}" class="text"/>
        </p>

        <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
      </fieldset>
    </g:form>
  </div>

</div>
</body>
</html>
