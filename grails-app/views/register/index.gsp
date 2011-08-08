<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title><g:message code="register.heading.label"/></title>
</head>
<body>
<content tag="sidebar"></content>

<content tag="body">

  <h1><g:message code="register.heading.label"/></h1>

  <g:if test="${flash.message}">
    <div class="success">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${command}">
    <g:renderErrors bean="${command}" as="list"/>
  </g:hasErrors>

  <g:form action="register" name="registerForm">

    <g:if test='${emailSent}'>
      <br/>
      <g:message code='spring.security.ui.register.sent'/>
    </g:if>
    <g:else>

      <div class="form_settings">
        <p><span><g:message code="register.username.label" default="Username"/></span><g:textField name="username" value="${command?.username}" class="text"/></p>

        <p><span><g:message code="register.email.label" default="E-Mail"/></span><g:textField name="email" value="${command?.email}" class="text"/></p>

        <p><span><g:message code="register.password.label" default="Password"/></span><g:passwordField name="password" value="${command?.password}" class="text"/></p>

        <p><span><g:message code="register.password2.label" default="Repeat password"/></span><g:passwordField name="password2" value="${command?.password2}" class="text"/></p>

        <br/>
        <p class="buttons"><input class="submit" type="submit" name="register" value="${message(code: 'register.button.register.label', default: 'Register')}"/></p>
      </div>
    </g:else>
  </g:form>
</content>

</body>
</html>
