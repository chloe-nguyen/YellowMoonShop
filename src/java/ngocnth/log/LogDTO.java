
package ngocnth.log;

import java.io.Serializable;
import java.util.Date;

public class LogDTO implements Serializable {
    
    private int logId;
    private Date date;
    private String username;
    private int productId;

    public LogDTO() {
    }

    public LogDTO(int logId, Date date, String username, int productId) {
        this.logId = logId;
        this.date = date;
        this.username = username;
        this.productId = productId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    
}
