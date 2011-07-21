<select name="region" id="region">
  <option value="">---</option>
  <g:each var="region" in="${regions}">
    <option <g:if test="${search?.region == region}">selected="selected"</g:if>>${region}</option>
  </g:each>
</select>