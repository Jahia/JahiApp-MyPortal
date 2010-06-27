package org.jahia.modules.portal;

import org.jahia.ajax.gwt.helper.ContentManagerHelper;
import org.jahia.bin.ActionResult;
import org.jahia.services.content.JCRSessionFactory;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * Created by IntelliJ IDEA.
 * User: david
 * Date: Feb 11, 2010
 * Time: 6:09:21 PM
 * To change this template use File | Settings | File Templates.
 */
public class CloneAction implements org.jahia.bin.Action {
    private String name;
    private ContentManagerHelper contentManager;

    public void setContentManager(ContentManagerHelper contentManager) {
        this.contentManager = contentManager;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ActionResult doExecute(HttpServletRequest req, RenderContext renderContext, Resource resource,
                                  Map<String, List<String>> parameters, URLResolver urlResolver) throws Exception {
        String sourcePath = req.getParameter("source");
        String targetPath = req.getParameter("target");
        String newName = req.getParameter("newName");
        JCRSessionWrapper jcrSessionWrapper = JCRSessionFactory.getInstance().getCurrentUserSession(resource.getWorkspace(), resource.getLocale());
        contentManager.copy(Arrays.asList(sourcePath),targetPath,null,false,false,true, false, jcrSessionWrapper);
        return new ActionResult(HttpServletResponse.SC_OK, null, new JSONObject());
    }
}