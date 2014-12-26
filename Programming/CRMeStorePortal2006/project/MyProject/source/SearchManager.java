

import java.io.IOException;
import java.util.ArrayList;

import javax.portlet.GenericPortlet;
import javax.portlet.PortletException;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import searchmanager.CatNode;

public class SearchManager extends GenericPortlet{
	CatNode cats[]={new CatNode("Books", -1, 0), new CatNode("Musics", -1, 1), new CatNode("Movies", -1, 2), 
					
					new CatNode("Scientific", 0, 3), new CatNode("Literature", 0, 4), new CatNode("Fiction", 0, 5), 
					new CatNode("A", 3, 6), new CatNode("B", 3, 7), new CatNode("C", 3, 8),
					new CatNode("A", 4, 9), new CatNode("B", 4, 10), new CatNode("C", 4, 11),
					new CatNode("A", 5, 12), new CatNode("B", 5, 13), new CatNode("C", 5, 14),
					
					new CatNode("Classic", 1, 15), new CatNode("Rock", 1, 16), new CatNode("Pop", 1, 17), 
					new CatNode("A", 15, 18), new CatNode("B", 15, 19), new CatNode("C", 15, 20),
					new CatNode("A", 16, 21), new CatNode("B", 16, 22), new CatNode("C", 16, 23),
					new CatNode("A", 17, 24), new CatNode("B", 17, 25), new CatNode("C", 17, 26),
					
					new CatNode("Horror", 2, 27), new CatNode("Action", 2, 28), new CatNode("Romance", 2, 29), 
					new CatNode("A", 27, 30), new CatNode("B", 27, 31), new CatNode("C", 27, 32),
					new CatNode("A", 28, 33), new CatNode("B", 28, 34), new CatNode("C", 28, 35),
					new CatNode("A", 29, 36), new CatNode("B", 29, 37), new CatNode("C", 29, 38),
					};
	protected void doView(RenderRequest request, RenderResponse response) throws PortletException, IOException{
		ArrayList path=new ArrayList();
		String category=request.getParameter("category_");
		if(category==null || category.equals(""))
			category=request.getParameter("category");
		if(category!=null && !category.equals(""))
			for(int cur=new Integer(category).intValue();cur!=-1; cur=cats[cur].getParentIndex())
				path.add(cats[cur]);
		ArrayList options=new ArrayList();
		if(category==null || category.equals("")){
			options.add(cats[0]);
			options.add(cats[1]);
			options.add(cats[2]);
		}else{
			int cur=new Integer(category).intValue();
			for(int i=0;i<cats.length;i++)
				if(cats[i].getParentIndex()==cur)
					options.add(cats[i]);
		}
		request.setAttribute("path", path);
		request.setAttribute("options", options);
		response.setContentType("text/html");
		PortletRequestDispatcher rd = getPortletContext().getRequestDispatcher("/webpages/searchmanager/index.jsp");
		rd.include(request, response);
	}
	protected void proccessAction(RenderRequest request, RenderResponse response) throws PortletException, IOException{
		response.setContentType("text/html");
		System.out.println("proccessAction()");
	}
}
