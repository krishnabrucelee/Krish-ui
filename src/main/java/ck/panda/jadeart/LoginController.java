package ck.panda.jadeart;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginController
 */
@WebServlet(name = "LoginController", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd = request
                .getRequestDispatcher("app/login.jsp");
		String value = System.getenv("REQUEST_PROTOCOL");
		request.setAttribute("REQUEST_PROTOCOL", value);

		String port = System.getenv("REQUEST_PORT");
		request.setAttribute("REQUEST_PORT", port);

		String folder = System.getenv("REQUEST_FOLDER");
		request.setAttribute("REQUEST_FOLDER", folder);
		
		Boolean debug = Boolean.valueOf(System.getenv("WEBSOCKET_CLIENT_DEBUG"));
		request.setAttribute("WEBSOCKET", debug);

        rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
