<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
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
<jcr:node var="subchild" path="${currentNode.properties['j:node'].node.path}"/>
<c:if test="${!empty subchild and jcr:isNodeType(subchild, 'jnt:contentList')}">
    <c:choose>
        <c:when test="${jcr:isNodeType(subchild, 'jmix:gadget')}"><template:module
                node="${subchild}"/></c:when>
        <c:otherwise>
            <script type="text/javascript">
                $(document).ready(function() {
                    $.get('<c:url value="${url.base}${subchild.path}.html.ajax"/>', null, function(data) {
                        $("#${currentResource.moduleParams.widgetContentId}").html(data);
                    });
                });
            </script>
        </c:otherwise>
    </c:choose>
</c:if>
<c:if test="${!empty subchild and !jcr:isNodeType(subchild, 'jnt:contentList')}">
    <template:module node="${subchild}" view="portal">
        <template:param name="widgetContentId" value="${currentResource.moduleParams.widgetContentId}"/>
    </template:module>
</c:if>
