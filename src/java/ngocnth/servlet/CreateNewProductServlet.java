package ngocnth.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ngocnth.category.CategoryDAO;
import ngocnth.product.ProductDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

@WebServlet(name = "CreateNewProductServlet", urlPatterns = {"/CreateNewProductServlet"})
public class CreateNewProductServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CreateNewProductServlet.class);
    
    private static final String INDEX = "index";
    private static final String ERROR_PAGE = "error_page";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR_PAGE;
        
        try {
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (isMultiPart) {
                //get toan bo du lieu va dua thanh list item
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List items = null;

                try {
                    items = upload.parseRequest(request);
                } catch (FileUploadException ex) {
                    LOGGER.info("FileUploadException: " + ex.getMessage());
                }

                Iterator iter = items.iterator();
                Hashtable params = new Hashtable(); //khai bao hashtable de lay cac tham so truyen qua control tren form...
                String image = null;

                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) //... ngoai tru file
                        params.put(item.getFieldName(), item.getString());
                    else {
                        try { //lay ten file
                            String itemName = item.getName();
                            image = itemName.substring(itemName.lastIndexOf("\\") + 1);
                        } catch (Exception ex) {
                            LOGGER.info("Exception: " + ex.getMessage());
                        }
                    }
                } //end while

                String name = (String) params.get("txtName");
                int price = Integer.parseInt((String) params.get("txtPrice"));
                int quanlity = Integer.parseInt((String) params.get("txtQuantity"));
                String mfg = (String) params.get("dateMfg");
                String exp = (String) params.get("dateExp");
                int status = 1;
                String category = (String) params.get("cboCategory");
                
                CategoryDAO cDao = new CategoryDAO();
                int categoryId = cDao.getCategoryId(category);
                
                ProductDAO pDao = new ProductDAO();
                boolean result = pDao.addProduct(name, image, price, quanlity, mfg, exp, status, categoryId);
                if (result)
                    url = INDEX;
            }
        } catch (NamingException ex) {
            LOGGER.info("NamingException: " + ex.getMessage());
        } catch (SQLException ex) {
            LOGGER.info("SQLException: " + ex.getMessage());
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
