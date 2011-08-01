<g:set var="comments" value="${commentable.comments}"></g:set>
<table id="comments" class="comments" style="width: 100%; border-spacing: 0pt;">
  <g:if test="${comments}">
  <g:render template="comment"
          collection="${comments}"
          var="comment"/>
    </g:if>
  <g:else>
    <g:message code="campsite.no_comments" default="No comments yet"/> 
  </g:else>
</table>
<sec:ifLoggedIn>
  <div id="addComment" class="addComment">
    <h2 class="addCommentTitle">
      <a href="#commentEditor" onclick="document.getElementById('addCommentContainer').style.display = '';">
        <g:message code="comment.add.title" default="Post a Comment"></g:message>
      </a>
    </h2>
    <div id="addCommentContainer" class="addCommentContainer" style="display:none;">
      <div class="addCommentDescription">
        <g:message code="comment.add.description" default=""></g:message>
      </div>
      <a name="commentEditor"></a>
      <div id="jserror"></div>
      <g:formRemote name="addCommentForm" url="[controller:'campsite',action:'addComment']" update="comments">
        <fckeditor:config EnterMode="br"/>
        <fckeditor:editor
                name="comment.body"
                width="100%"
                height="200"
                toolbar="Basic"/>
        <g:hiddenField name="update" value="comments"/>
        <g:hiddenField name="commentLink.commentRef" value="${commentable.id}"/>
        <g:hiddenField name="commentLink.type" value="${commentable.class.name}"/>
        <g:hiddenField name="commentPageURI" value="${request.forwardURI}"></g:hiddenField>
        <g:submitButton name="submit" value="${g.message(code:'comment.post.button.name', 'default':'Post')}"
                onclick="parent.frames[0].FCK.UpdateLinkedField();"></g:submitButton>
      </g:formRemote>
    </div>
  </div>
</sec:ifLoggedIn>
<sec:ifNotLoggedIn>
  <i><g:message code="comment.error.not_authorized"/></i>
</sec:ifNotLoggedIn>