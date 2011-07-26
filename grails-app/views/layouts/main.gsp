<!DOCTYPE html>
<html>
<head>
  <title><g:layoutTitle default="Grails"/></title>
  <link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'screen.css')}" type="text/css" media="screen, projection"/>
  <link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint', file: 'print.css')}" type="text/css" media="print"/>
  <!--[if IE]><link rel="stylesheet" href="${createLinkTo(dir: 'css/blueprint',
          file: 'ie.css')}" type="text/css" media="screen, projection"/><![endif]-->
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
  <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon"/>
  <g:javascript library="application"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <g:layoutHead/>
</head>
<body>
<div class="container">

  <div class="span-24" id="head">
    <h1 class="heading">Womomo.de</h1>
    <p class="subheading">Die Wohnmobil und Stellplatz Community im Netz</p>
  </div>

  <g:layoutBody/>

  <div class="span-24" id="bottom">
    womomo.de
  </div>

</div>
</body>
</html>