package ck.panda.jadeart;


/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;

public class CaptchaServlet extends HttpServlet {

protected TextOptions options;

	/** Text options. */
	public enum TextOptions{
		/** Number format only.*/
		NUMBERS_ONLY,

		NUMBERS_AND_LETTERS
	}

  protected void processRequest(HttpServletRequest request,
                                HttpServletResponse response)
                 throws ServletException, IOException {

    int width = 125;
    int height = 38;

   char data[][] = {
    	{ '2', '1', 'a', '6', 'b', 'c' },
        { 'd', '4', '8', 'e', '1' },
        { '9', 'f', '3', 'g', '8', 'h', '4' },
        { '0', '1', 'k', '5', 'j', '7' },
        { '5', 'm', '8'}
    };

    BufferedImage bufferedImage = new BufferedImage(width, height,
                  BufferedImage.TYPE_INT_RGB);
    Graphics2D g2d = bufferedImage.createGraphics();
    Font font = new Font("SansSerif", Font.BOLD+Font.ITALIC, 18);
    g2d.setFont(font);
    RenderingHints rh = new RenderingHints(
           RenderingHints.KEY_ANTIALIASING,
           RenderingHints.VALUE_ANTIALIAS_ON);
    rh.put(RenderingHints.KEY_RENDERING,
           RenderingHints.VALUE_RENDER_QUALITY);
    g2d.setRenderingHints(rh);

    Color blue = new Color(143, 203, 233);
    Color grey1 = new Color(0,0,0);
    GradientPaint gp = new GradientPaint(0, 0, blue, 0, height/2,blue, false);
    g2d.setPaint(gp);
    g2d.fillRect(0, 0, width, height);
    g2d.setColor(new Color(0, 0, 0));
    Random r = new Random(System.currentTimeMillis());
	CharArrayWriter cab = new CharArrayWriter();
	String answer = "";
	for(int i = 0; i < 5; i ++){
		int u_l_n = r.nextInt(3);
		char ch = ' ';
		switch(u_l_n){

		//UpperCase
	    case 0:
	    	ch = (char)(r.nextInt(91 - 65) + (65));
	    	break;
	    //LowerCase
	    case 1:
	    	ch = (char)(r.nextInt(123 - 97) + (97));
	    	break;
	    //Numbers
	    case 2:
	    	ch = (char)(r.nextInt(58 - 49) + (49));
	    	break;
	    }
			cab.append(ch);
			answer += ch;
		}

	char[] data1 = cab.toCharArray();
    Random r1 = new Random();
    int index = Math.abs(r1.nextInt()) % 5;
    String captcha = String.copyValueOf(data1);
    request.getSession().setAttribute("captcha", captcha );
    int x = 0;
    int y = 0;
    for (int i=0; i<data1.length; i++) {
        x += 10 + (Math.abs(r.nextInt()) % 15);
        y = 20 + Math.abs(r.nextInt()) % 20;
        g2d.drawChars(data1, i, 1, x, y);
    }
    g2d.dispose();
    response.setContentType("image/png");
    OutputStream os = response.getOutputStream();
    ImageIO.write(bufferedImage, "png", os);
    os.close();
  }

  /**
   * HttpServlet get method with request and response .
   *
   */
  protected void doGet(HttpServletRequest request,
                       HttpServletResponse response)
                           throws ServletException, IOException {
      processRequest(request, response);

  }

  /**
   * HttpServlet post method with request and response .
   *
   */
  protected void doPost(HttpServletRequest request,
                        HttpServletResponse response)
                            throws ServletException, IOException {
	 String answer = "";
     String captcha = null;
     String captchas = (String) request.getSession().getAttribute("captcha");
  	 request.getHeader("x-answer");
  	 response.setContentType("application/json");
  	 answer = request.getHeader("x-answer");
  	 if	(captchas.equals(answer)) {
  			response.getWriter().write("{\"result\":\"" +"success"+ "\"}");
  	} else{
  			response.getWriter().write("{\"result\":\"" +"failure"+ "\"}");
  	}
  }
}