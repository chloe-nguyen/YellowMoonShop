
package ngocnth.listener;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

public class MyServletListener implements ServletContextListener, HttpSessionListener {

    private static final Logger LOGGER = Logger.getLogger(ServletContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //Khoi tao file log
        ServletContext context = sce.getServletContext();
        String log4jConfigFile = context.getInitParameter("log4j-config-location");
        String fullPath = context.getRealPath("/") + log4jConfigFile;
        
        PropertyConfigurator.configure(fullPath);
        
        //Khoi tao map tham chieu den resource
        Map<String, String> lableMap = null;
        FileReader f = null;
        BufferedReader bf = null;
        
        String realPath = context.getRealPath("/");
        String path = realPath + "WEB-INF/lableMap.txt";
        
        try {
            f = new FileReader(path);
            bf = new BufferedReader(f);
            
            while (bf.ready()) {
                String line = bf.readLine();
                String[] arr = line.split("=");
                if (arr.length == 2) {
                    if (lableMap != null)
                        lableMap.put(arr[0], arr[1]);
                    else {
                        lableMap = new HashMap<>();
                        lableMap.put(arr[0], arr[1]);
                    }
                }
            }
            context.setAttribute("LABLE_MAP", lableMap);
            
        } catch (FileNotFoundException ex ) {
            LOGGER.info("FileNotFoundException: " + ex.getMessage());
        } catch (IOException ex) {
            LOGGER.info("IOException: " + ex.getMessage());
        } finally {
            try {
                if (bf != null)
                    bf.close();
                
                if (f != null)
                    f.close();
            } catch (IOException ex) {
                LOGGER.info("IOException: " + ex.getMessage());
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        List<String> list = new ArrayList<>();
        list.add("0 - 100.000 vnd");
        list.add("100.000 - 200.000 vnd");
        list.add("200.000 - 500.000 vnd");
        
        HttpSession session = se.getSession();
        session.setAttribute("PRICE_RANGE", list);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
    }
}
