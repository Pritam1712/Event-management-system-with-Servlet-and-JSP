package event;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateEventServlet")
public class UpdateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Retrieve and validate parameters
        String eventIdStr = request.getParameter("event_id");
        String eventName = request.getParameter("name");
        String eventDateStr = request.getParameter("date");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String eventType = request.getParameter("type");

        // Input Validation
        if (eventIdStr == null || eventIdStr.isEmpty() ||
            eventName == null || eventName.isEmpty() ||
            eventDateStr == null || eventDateStr.isEmpty() ||
            location == null || location.isEmpty() ||
            description == null || description.isEmpty() ||
            eventType == null || eventType.isEmpty()) {
            
            response.sendRedirect("edit-event.jsp?error=All fields are required");
            return;
        }

        int eventId;
        Date eventDate;
        
        try {
            // Parse inputs
            eventId = Integer.parseInt(eventIdStr);
            eventDate = Date.valueOf(eventDateStr); // Convert to SQL Date
        } catch (IllegalArgumentException e) { // No need for NumberFormatException
            response.sendRedirect("edit-event.jsp?event_id=" + eventIdStr + "&error=Invalid date or ID");
            return;
        }

        // Get Database Connection
        Connection conn = DBConnection.getConnection();
        if (!DBConnection.isConnectionActive()) {
            conn = DBConnection.getConnection(); // Re-establish connection if closed
        }
        
        EventDAO eventDAO = new EventDAO(conn);

        // Database Operation
		boolean updated = eventDAO.updateEvent(eventId, eventName, eventDate, location, description, eventType);
		
		if (updated) {
		    response.sendRedirect("admin-dashboard.jsp?success=Event Updated Successfully");
		} else {
		    response.sendRedirect("edit-event.jsp?event_id=" + eventId + "&error=Update Failed");
		}
    }
}