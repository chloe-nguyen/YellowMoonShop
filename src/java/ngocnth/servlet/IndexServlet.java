
package ngocnth.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ngocnth.account.AccountDTO;
import ngocnth.category.CategoryDAO;
import ngocnth.category.CategoryDTO;
import ngocnth.product.ProductDAO;
import ngocnth.product.ProductDTO;
import org.apache.log4j.Logger;

@WebServlet(name = "IndexServlet", urlPatterns = {"/IndexServlet"})
public class IndexServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(IndexServlet.class);
    
    private static final String INDEX_PAGE = "index_page";
    private static final String ERROR_PAGE = "error_page";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String url = ERROR_PAGE;
        //String isAdmin = request.getParameter("isAdmin");
        int totalProduct;
        List<ProductDTO> pList;
        
        try {
            HttpSession session = request.getSession();
            
            CategoryDAO cDao = new CategoryDAO();
            List<CategoryDTO> cList = cDao.getCategories();
            if (cList != null)
                session.setAttribute("CATEGORIES", cList);
            
            AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNT");
            ProductDAO dao = new ProductDAO();
            if (account != null && account.getRole() == 1) { //is Admin
                totalProduct = dao.countTotalProducts();
                pList = dao.getProducts();
            } else {
                totalProduct = dao.countAvailableProducts();
                pList = dao.getAvailableProducts();
            }
            
            if (pList != null) {
                session.setAttribute("TOTAL_PRODUCT", totalProduct);
                session.setAttribute("LIST_PRODUCT", pList);
                url = INDEX_PAGE;
            }
        } catch (NamingException ex) {
            LOGGER.info("NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            LOGGER.info("SQLException: " + ex.getMessage());
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
