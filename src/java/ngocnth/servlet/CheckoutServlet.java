package ngocnth.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ngocnth.cart.Cart;
import ngocnth.cart.CartDAO;
import ngocnth.cart.CartDTO;
import ngocnth.product.ProductDAO;
import org.apache.log4j.Logger;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CheckoutServlet.class);

    private static final String CART_PAGE = "cart_page";
    private static final String SHOW_BILL_PAGE = "show_bill_page";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = CART_PAGE;

        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart != null) {
                    String username = request.getParameter("txtUsername");
                    String fullname = request.getParameter("txtFullname");
                    String phone = request.getParameter("txtPhone");
                    String address = request.getParameter("txtAddress");
                    Date date = new Date();
                    int totalPrice = cart.getTotalPrice();

                    CartDAO cDao = new CartDAO();
                    int cartId = cDao.saveCart(username, fullname, phone, address, date, totalPrice, cart.getCart());
                    if (cartId > 0) {
                        ProductDAO pDao = new ProductDAO();
                        pDao.updateProductStatus();

                        CartDTO dto = cDao.getCart(cartId);
                        if (dto != null) {
                            session.setAttribute("UID_CART", dto.getCartId());
                            session.removeAttribute("INVALID_QUANTITY");
                            url = SHOW_BILL_PAGE;
                        }
                    } else {
                        session.setAttribute("INVALID_QUANTITY", true);
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.info("SQLException: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("NamingException: " + ex.getMessage());
        } finally {
            //response.sendRedirect(url);
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
