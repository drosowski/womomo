<sec:ifLoggedIn>
  <h3><g:message code="login.welcome.label" default="Welcome"/>!</h3>
  <strong><sec:username/></strong><br/>
  <br/>
  <ul>

    <li><a href="${createLink(controller: "userAccount", action: "profile", id: sec.loggedInUserInfo(field: "id"))}"><g:message code="login.profile.label"/></a></li>
    <li><a href="${createLink(controller: "logout")}"><g:message code="login.logout.label"/></a></li>
  </ul>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
  <form method="post" action="${request.contextPath}/j_spring_security_check">

    <h3><g:message code="login.heading.label" default="Login"/></h3>

    <div class="sidebar_form_settings">
      <input type="hidden" name="spring-security-redirect" value="${request.forwardURI - request.contextPath}"
      <p><span><g:message code="userAccount.username.label" default="Username"/></span><input type="text" name="j_username"/></p>
      <p><span><g:message code="userAccount.password.label" default="Password"/></span><input type="password" name="j_password"/></p>
      <p><sub><g:message code="login.register.no_account"/><br/>
        <a href="${createLink(controller: "register")}"><g:message code="login.register.here"/></a></sub></p>
      <p><span>&nbsp;</span><input class="submit" type="submit" name="name" value="${message(code: 'button.login.label', default: 'Login')}"/></p>
    </div>
  </form>
</sec:ifNotLoggedIn>