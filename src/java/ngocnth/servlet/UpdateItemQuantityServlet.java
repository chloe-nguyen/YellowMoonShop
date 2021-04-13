package ngocnth.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ngocnth.cart.Cart;
import org.apache.log4j.Logger;

@WebServlet(name = "UpdateItemQuantityServlet", urlPatterns = {"/UpdateItemQuantityServlet"})
public class UpdateItemQuantityServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateItemQuantityServlet.class);

    private static final String CART_PAGE = "cart_page";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = CART_PAGE;

        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                int id = Integer.parseInt(request.getParameter("txtId"));
                int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart != null) {
                    boolean result = cart.updateItemQuantity(id, quantity);
                    if (result) {
                        session.setAttribute("CART", cart);
                        session.removeAttribute("INVALID_QUANTITY");

                    } else {
                        session.setAttribute("INVALID_QUANTITY", true);
                    }
                }
            }
        } catch (Exception ex) {
            LOGGER.info("Exception: " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
