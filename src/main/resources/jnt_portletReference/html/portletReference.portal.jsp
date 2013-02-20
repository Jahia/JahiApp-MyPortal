<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<template:addResources type="javascript" resources="jquery.min.js"/>
<template:addResources type="css" resources="portlet-spec-1.0.css,portlets.css"/>
<jcr:nodeProperty node="${currentNode}" name="j:node" var="portletNode"/>
<div id="Portlet${currentNode.identifier}">
<c:if test="${!empty portletNode}">
    <ui:portletModes node="${portletNode.node}" var="modes"/>
    <ul class="portletModes">
    <c:forEach items="${modes}" var="mode">
        <c:url var="urlPortlet" value="${url.base}${currentNode.path}.portal.html.ajax?${fn:substringAfter(mode.value,'?')}"/>
    <li><a href="#" onclick="replace('Portlet${currentNode.identifier}','${urlPortlet}',null);return false;"><span>${mode.key}</span></a></li>
    </c:forEach>
    </ul>
    <ui:portletRender portletNode="${portletNode.node}" />
</c:if>
</div>