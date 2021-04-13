package ngocnth.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ngocnth.cart.Cart;
import ngocnth.product.ProductDTO;
import org.apache.log4j.Logger;

@WebServlet(name = "AddItemToCartServlet", urlPatterns = {"/AddItemToCartServlet"})
public class AddItemToCartServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AddItemToCartServlet.class);
    
    private static final String INDEX = "index";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = INDEX;
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                int id = Integer.parseInt(request.getParameter("txtId"));
                String name = request.getParameter("txtName");
                String img = request.getParameter("txtImg");
                int price = Integer.parseInt(request.getParameter("txtPrice"));
                int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-DD");
                Date mfg = formatter.parse(request.getParameter("txtMfg"));
                Date exp = formatter.parse(request.getParameter("txtExp"));
                int status = Integer.parseInt(request.getParameter("txtStatus"));
                int category = Integer.parseInt(request.getParameter("txtCategory"));

                ProductDTO product = new ProductDTO(id, name, img, price, quantity, mfg, exp, status, category);
                
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart == null)
                    cart = new Cart();
                
                cart.addItemToCart(product);
                session.setAttribute("CART", cart);
            }

        } catch (ParseException ex) {
            LOGGER.info("ParseException: " + ex.getMessage());
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
