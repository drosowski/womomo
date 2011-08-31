<tr id="comment${comment.id}" class="comment">
  <td>
    <a href="#comment_${comment.id}" name="comment_${comment.id}">
      ${comment?.poster.username}, <g:formatDate date="${comment.dateCreated}" format="dd.MM.yyyy HH:mm"/>
    </a>

    <plugin:isAvailable name="avatar">
      <span class="left">
        <avatar:gravatar cssClass="commentAvatar" size="50"
                email="${comment?.poster.email}" gravatarRating="R"
                defaultGravatarUrl="${createLinkTo(absolute: true, dir:'/images',file:'default_gravatar.jpg').encodeAsURL()}"/>
      </span>
    </plugin:isAvailable>

    <p>${comment?.body}</p>
  </td>
</tr>
