<%@ page import="de.womomo.Campsite" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}"/>
  <title><g:message code="default.show.label" args="[entityName]"/></title>
  <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>
  <script type="text/javascript">
    function initMap() {
      var center = new google.maps.LatLng(${campsiteInstance.latitude}, ${campsiteInstance.longitude});
      var myOptions = {
        zoom: 13,
        center: center,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById("map"), myOptions);
      var marker = new google.maps.Marker({
        position: center,
        map: map,
        title:"${campsiteInstance.name}"
      });
    }
    $(document).ready(initMap);
  </script>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
</div>
<div class="body">
  <h1><g:message code="default.show.label" args="[entityName]"/></h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="campsite.id.label" default="Id"/></td>
        <td valign="top" class="value">${fieldValue(bean: campsiteInstance, field: "id")}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="campsite.address.label" default="Address"/></td>
        <td valign="top" class="value">${fieldValue(bean: campsiteInstance, field: "address")}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="campsite.latitude.label" default="Latitude"/></td>
        <td valign="top" class="value">${fieldValue(bean: campsiteInstance, field: "latitude")}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="campsite.longitude.label" default="Longitude"/></td>
        <td valign="top" class="value">${fieldValue(bean: campsiteInstance, field: "longitude")}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="campsite.name.label" default="Name"/></td>
        <td valign="top" class="value">${fieldValue(bean: campsiteInstance, field: "name")}</td>
      </tr>

      <div id="comments">
        <tr class="prop">
          <td valign="top" class="name"><g:message code="campsite.comments.label" default="Comments"/></td>
          <td valign="top" class="value">
            <table>
              <comments:each bean="${campsiteInstance}">
                <tr>
                  <td valign="top" class="name">${comment.poster}</td>
                  <td valign="top" class="value">${comment.body}</td>
                </tr>
              </comments:each>
            </table>
          </td>
        </tr>

        <sec:ifLoggedIn>
          <g:form>
            <g:hiddenField name="id" value="${campsiteInstance?.id}"/>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="comment"><g:message code="campsite.newComment.label" default="New comment"/></label>
              </td>
              <td valign="top" class="value">
                <g:textArea name="comment"/><br/>
                <span class="button"><g:actionSubmit action="addComment" value="${message(code: 'button.addComment.label', default: 'Add comment')}"/></span>
              </td>
            </tr>
          </g:form>
        </sec:ifLoggedIn>
      </div>

      </tbody>
    </table>
  </div>
  <div class="buttons">
    <g:form>
      <g:hiddenField name="id" value="${campsiteInstance?.id}"/>
      <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
    </g:form>
  </div>
  <div id="map" style="width: 500px; height: 300px"></div>>
</div>
</body>
</html>
