<span><g:message code="campsite.filter.region.label" default="Region"/></span>
<select name="region" id="region" onchange="document.forms['filter'].submit();">
  <option value="">---</option>
  <g:each var="region" in="${regions}">
    <option <g:if test="${filter?.region == region}">selected="selected"</g:if>>${region}</option>
  </g:each>
</select>