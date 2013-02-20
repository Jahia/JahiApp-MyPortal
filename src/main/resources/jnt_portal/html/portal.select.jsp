<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<template:addResources type="css" resources="portal.css"/>
<template:addResources type="javascript" resources="jquery.min.js,jquery-ui.min.js,inettuts.js"/>
<jcr:node path="${param['path']}" var="widgets"/>
<template:addCacheDependency flushOnPathMatchingRegexp="\Q${widgets.path}\E/.*" />
<div class="content clearfix">
    <div class="left">
        <h3><fmt:message key="label.portal.addComponents"/></h3>
        <ul class="panellist">
            <c:forEach items="${widgets.nodes}" var="node" varStatus="status">
                <c:if test="${!jcr:isNodeType(node, 'jnt:acl' )}">
                    <c:if test="${jcr:isNodeType(node, 'jmix:nodeReference')}">
                        <%-- Add dependency to references --%>
                        <template:addCacheDependency uuid="${node.properties['j:node'].string}"/>
                    </c:if>
                    <c:set var="widgetTitle" value="${functions:removeHtmlTags(node.displayableName)}"/>
                    <li>
                        <div ondblclick="addWidget('${node.path}','${node.name}')">
                            <span>${fn:substring(widgetTitle, 0,40)} ${fn:length(widgetTitle) > 40?" ...":""}</span>
                        </div>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
    <div class="left">
        <h3><fmt:message key="label.portal.addRSS"/></h3>
        <form class="Form" action="" method="post">
            <p>
                <label><fmt:message key="label.portal.rss.feedURL"/> :</label>
                <input type="text" name="feedUrl" id="feedUrl" maxlength="256"/>
            </p>

            <p>
                <label><fmt:message key="label.portal.rss.noOfFeeds"/> :</label>
                <input type="text" name="nbFeeds" id="nbFeeds" maxlength="2" value="5"/>
            </p>
        </form>
        <button name="addRss" type="button" value='<fmt:message key="label.portal.addRSS"/>' onclick="addRSSWidget()"><fmt:message key="label.portal.addRSSWidget"/></button>

    </div>
    <div class="left right">

        <h3><fmt:message key="label.portal.addScriptGadget"/></h3>

        <form class="Form" action="" method="post">
            <p>
                <label><fmt:message key="label.portal.script"/> :</label>
                <input type="text" name="scriptGadget" id="scriptGadget"/>
            </p>
        </form>
        <button name="addScript" type="button" value='<fmt:message key="label.portal.addScriptGadget"/>' onclick="addScriptWidget()"><fmt:message key="label.portal.addScriptWidget"/></button>

    </div>
</div>