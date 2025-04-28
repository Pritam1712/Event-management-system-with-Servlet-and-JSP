package event;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingIdStr = request.getParameter("booking_id");
        String eventIdStr = request.getParameter("event_id");

        if (bookingIdStr != null && eventIdStr != null) {
            int bookingId = Integer.parseInt(bookingIdStr);
            int eventId = Integer.parseInt(eventIdStr);

            BookingDAO bookingDAO = new BookingDAO(DBConnection.getConnection());
            boolean success = bookingDAO.deleteBooking(bookingId);

            if (success) {
                response.sendRedirect("view-bookings.jsp?event_id=" + eventId + "&success=Booking deleted successfully");
            } else {
                response.sendRedirect("view-bookings.jsp?event_id=" + eventId + "&error=Failed to delete booking");
            }
        }
    }
}
