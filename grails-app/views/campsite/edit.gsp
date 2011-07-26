<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}"/>
  <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>
<body>
<div class="body">

  <h1><g:message code="default.edit.label" args="[entityName]"/></h1>

  <div class="span-24">
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${campsiteInstance}">
      <div class="errors">
        <g:renderErrors bean="${campsiteInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form method="post">
      <fieldset>
        <g:hiddenField name="id" value="${campsiteInstance?.id}"/>
        <g:hiddenField name="version" value="${campsiteInstance?.version}"/>

        <p>
          <label for="address"><g:message code="campsite.address.label" default="Address"/></label><br/>
          <g:textField name="address" value="${campsiteInstance?.address}"/>
        </p>

        <p>
          <label for="latitude"><g:message code="campsite.latitude.label" default="Latitude"/></label><br/>
          <g:textField name="latitude" value="${campsiteInstance?.latitude}"/>
        </p>

        <p>
          <label for="longitude"><g:message code="campsite.longitude.label" default="Longitude"/></label><br/>
          <g:textField name="longitude" value="${campsiteInstance?.longitude}"/>
        </p>

        <p>
          <label for="name"><g:message code="campsite.name.label" default="Name"/></label><br/>
          <g:textField name="name" value="${campsiteInstance?.name}"/>
        </p>

        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
      </fieldset>
    </g:form>
  </div>

</div>
</body>
</html>
