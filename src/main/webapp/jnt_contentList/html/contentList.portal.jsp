<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="propertyDefinition" type="org.jahia.services.content.nodetypes.ExtendedPropertyDefinition"--%>
<%--@elvariable id="type" type="org.jahia.services.content.nodetypes.ExtendedNodeType"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<c:if test="${!renderContext.editMode}">
    <c:forEach items="${currentNode.nodes}" var="subchild">
        <template:addCacheDependency uuid="${subchild.identifier}"/>
        <c:if test="${jcr:isNodeType(subchild, 'jmix:nodeReference')}">
            <template:addCacheDependency uuid="${subchild.properties['j:node'].string}"/>
            <c:set var="subSubChild" value="${subchild.contextualizedNode}"/>
            <c:if test="${jcr:isNodeType(subSubChild, 'jmix:nodeReference')}">
                <template:addCacheDependency uuid="${subSubChild.properties['j:node'].string}"/>
            </c:if>
        </c:if>
        <li class="widget color-box" id="${subchild.path}">
            <div class="widget-head">
                <h3>${subchild.displayableName}</h3>
            </div>
            <div class="widget-content" id="widget${subchild.UUID}">
                <template:module node="${subchild}" view="portal">
                    <template:param name="widgetContentId" value="${subchild.UUID}"/>
                    <template:param name="widgetContentPrefix" value="widget"/>
                </template:module>
            </div>
        </li>
    </c:forEach>
</c:if>
<c:if test="${renderContext.editMode}">
    <li class="widget color-box"><fmt:message
            key="label.portal.column"/>&nbsp;${fn:substring(currentNode.name,6,7)}</li>
    <c:forEach items="${currentNode.nodes}" var="subchild">
        <li class="widget color-box" id="${subchild.path}">
            <jcr:node var="n" path="${subchild.properties['j:node'].node}"/>
            <c:if test="${!empty n}">
                <template:module node="${subchild}"/>
            </c:if>
        </li>
    </c:forEach>
    <li>
        <template:module path="*"/>
    </li>
</c:if>
