package ck.panda.jadeart;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class IndexController
 */
@WebServlet(name = "IndexController", urlPatterns = { "/index" })
public class IndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor.
     */
    public IndexController() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String language;

		Cookie[] cookies = request.getCookies();

		// Default Language
		String languageString = "en";
		// Get the selected language from cookie
		if(cookies == null){
			Cookie cookie=new Cookie("lang","en");
			cookie.setMaxAge(3000);
			response.addCookie(cookie);
		}
		else{
		for(Cookie cookie : cookies){
			System.err.println("Language:"+ cookie.getName());
		    if("ls.language".equals(cookie.getName())){
		    	languageString = cookie.getValue();
		    }
		}
		}

        language = new String(languageString);

        Locale currentLocale;
        ResourceBundle messages;

        currentLocale = new Locale(language);
        messages = ResourceBundle.getBundle("i18n/messages", currentLocale);
        request.setAttribute("messages", messages);
        request.setAttribute("lang", languageString);

        // server could be temporarily unavailable fix.
        response.setLocale(currentLocale);
        request.getSession().setAttribute("javax.servlet.jsp.jstl.fmt.locale.session", languageString);
        request.getSession().setAttribute("language", languageString);
        String value = System.getenv("REQUEST_PROTOCOL");
		request.setAttribute("REQUEST_PROTOCOL", value);

		String port = System.getenv("REQUEST_PORT");
		request.setAttribute("REQUEST_PORT", port);

		String folder = System.getenv("REQUEST_FOLDER");
		request.setAttribute("REQUEST_FOLDER", folder);

		Boolean debug = Boolean.valueOf(System.getenv("WEBSOCKET_CLIENT_DEBUG"));
		request.setAttribute("WEBSOCKET", debug);

        RequestDispatcher rd = request
                .getRequestDispatcher("app/index.jsp");
        rd.forward(request, response);
	}

}
