<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>All Post</h2>

        <security:authorize access="hasRole('ADMIN')">    
            <a href="<c:url value="/user" />">Manage User Accounts</a><br /><br />
        </security:authorize>
        <a href="<c:url value="/ticket/create" />">New Post</a>
        <a href="<c:url value="/ticket/listlecture" />">lecture</a>
        <a href="<c:url value="/ticket/listlab" />">lab</a>
        <a href="<c:url value="/ticket/listother" />">other</a>
        <a href="<c:url value="/ticket/list" />">all</a>
        <br /><br />
        <c:choose>
            <c:when test="${fn:length(ticketDatabase) == 0}">
                <i>0 Post.</i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${ticketDatabase}" var="entry4">
                    <c:if test="${entry4.categories == 'other'}" >
                        Post #${entry4.id}:
                        <a href="<c:url value="/ticket/view/${entry4.id}" />"> 
                            <c:out value="${entry4.subject}" /></a>
                        (Post by: <c:out value="${entry4.customerName}" />)                    
                    <security:authorize access="hasRole('ADMIN') or principal.username=='${entry4.customerName}'">            
                        [<a href="<c:url value="/ticket/edit/${entry4.id}" />">Edit</a>]
                    </security:authorize>
                    <security:authorize access="hasRole('ADMIN')">            
                        [<a href="<c:url value="/ticket/delete/${entry4.id}" />">Delete</a>]
                    </security:authorize>
                    <hr>
                    </c:if>  
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </body>
</html>