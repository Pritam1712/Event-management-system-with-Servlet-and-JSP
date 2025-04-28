package event;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // You can add initialization code here if necessary
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            // Stop the abandoned connection cleanup thread
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.uncheckedShutdown();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

