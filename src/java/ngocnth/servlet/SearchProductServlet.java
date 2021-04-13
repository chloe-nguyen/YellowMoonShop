package ngocnth.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ngocnth.account.AccountDTO;
import ngocnth.product.ProductDAO;
import ngocnth.product.ProductDTO;
import org.apache.log4j.Logger;

@WebServlet(name = "SearchProductServlet", urlPatterns = {"/SearchProductServlet"})
public class SearchProductServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SearchProductServlet.class);

    private static final int DEFAULT_MIN_PRICE = 1;
    private static final int DEFAULT_MAX_PRICE = 500000;
    
    private static final String INDEX_PAGE = "index_page";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String searchValue = request.getParameter("txtSearchValue");
        String priceRange = request.getParameter("cboPrice");
        String category = request.getParameter("cboCategory");
        int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        
        int productPerPage = 21;
        int skipRows = (pageNumber - 1) * productPerPage;
        int nextRows = productPerPage;

        //price range options
        String c1 = "0 - 100.000 vnd"; 
        String c2 = "100.000 - 200.000 vnd";
        String c3 = "200.000 - 500.000 vnd";

        int minPrice = DEFAULT_MIN_PRICE;
        int maxPrice = DEFAULT_MAX_PRICE;

        if (priceRange.equals(c1)) 
            maxPrice = 100000;
        else if (priceRange.equals(c2)) {
            minPrice = 100000;
            maxPrice = 200000;
        } else if (priceRange.equals(c3))
            minPrice = 200000;
        
        if (category.equals("Category"))
            category = "";
        
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                int totalProduct;
                List<ProductDTO> list;
                ProductDAO pDao = new ProductDAO();
                AccountDTO account = (AccountDTO) session.getAttribute("ACCOUNT");               
                
                if (account != null && account.getRole() == 1) {
                    totalProduct = pDao.countSearchProducts(searchValue, minPrice, maxPrice, category, skipRows, nextRows);
                    list = pDao.searchProducts(searchValue, minPrice, maxPrice, category, skipRows, nextRows);
                } else {
                    totalProduct = pDao.countSearchAvailableProducts(searchValue, minPrice, maxPrice, category, skipRows, nextRows);
                    list = pDao.searchAvailableProducts(searchValue, minPrice, maxPrice, category, skipRows, nextRows);
                }

                session.setAttribute("TOTAL_PRODUCT", totalProduct);
                session.setAttribute("LIST_PRODUCT", list);
            }
        } catch (SQLException ex) {
            LOGGER.info("SQLException: " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.info("NamingException: " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(INDEX_PAGE);
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
