
<%@ page import="de.womomo.Campsite" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'campsite.label', default: 'Campsite')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'campsite.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="address" title="${message(code: 'campsite.address.label', default: 'Address')}" />
                        
                            <g:sortableColumn property="latitude" title="${message(code: 'campsite.latitude.label', default: 'Latitude')}" />
                        
                            <g:sortableColumn property="longitude" title="${message(code: 'campsite.longitude.label', default: 'Longitude')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'campsite.name.label', default: 'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${campsiteInstanceList}" status="i" var="campsiteInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${campsiteInstance.id}">${fieldValue(bean: campsiteInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: campsiteInstance, field: "address")}</td>
                        
                            <td>${fieldValue(bean: campsiteInstance, field: "latitude")}</td>
                        
                            <td>${fieldValue(bean: campsiteInstance, field: "longitude")}</td>
                        
                            <td>${fieldValue(bean: campsiteInstance, field: "name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${campsiteInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
