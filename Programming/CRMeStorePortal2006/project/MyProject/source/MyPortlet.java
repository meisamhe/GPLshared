
import java.io.IOException;

import javax.portlet.GenericPortlet;
import javax.portlet.PortletException;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

public class MyPortlet extends GenericPortlet{
	protected void doView(RenderRequest request, RenderResponse response) throws PortletException, IOException{
		response.setContentType("text/html");
		System.err.println("testing........");
		PortletRequestDispatcher rd = getPortletContext().getRequestDispatcher("/webpages/myportlet/index.jsp");
		rd.include(request, response);
	}
	protected void proccessAction(RenderRequest request, RenderResponse response) throws PortletException, IOException{
		response.setContentType("text/html");
		System.out.println("proccessAction()");
	}
	
}
