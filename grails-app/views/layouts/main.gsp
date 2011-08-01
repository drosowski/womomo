<!DOCTYPE html>
<html>
<head>
  <title><g:layoutTitle default="Womomo.de"/></title>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}"/>
  <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
  <g:javascript library="application"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <g:layoutHead/>
</head>
<body>
<div id="main">

  <div id="header">
    <div id="logo">
      <div id="logo_text">
        <!-- class="logo_colour", allows you to change the colour of the text -->
        <h1><a href="${createLink(uri: "/")}">Womomo<span class="logo_colour">.de</span></a></h1>
        <h2>Die Wohnmobil und Stellplatz Community im Netz.</h2>
      </div>
    </div>
    <div id="menubar">
      <ul id="menu">
        <!-- put class="selected" in the li tag for the selected page - to highlight which page you're on -->
        <li><a href="${createLink(uri: "/")}"><g:message code="topnav.overview.label" default="Overview"/></a></li>
        <li><a href="${createLink(controller: "campsite", action: "create")}"><g:message code="topnav.add_campsite.label" default="Add Campsite"/></a></li>
        <li><a href="${createLink(controller: "route")}"><g:message code="topnav.route.label" default="Route"/></a></li>
        <li><a href="${createLink(uri: "/")}"><g:message code="topnav.myprofile.label" default="My Profile"/></a></li>
      </ul>
    </div>
  </div>

  <div id="content_header"></div>

  <div id="site_content">
    <div id="sidebar_container">
      <div class="sidebar">
        <div class="sidebar_top"></div>
        <div class="sidebar_item">
          <g:render template="/loginSidebar"/> 
        </div>
        <div class="sidebar_base"></div>
      </div>
      <g:pageProperty name="page.sidebar"/>
    </div>

    <div id="content">
      <g:pageProperty name="page.body"/>
    </div>
  </div>

  <div id="content_footer"></div>

  <div id="footer">
    womomo.de
  </div>

</div>
</body>
</html>