package event;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO(DBConnection.getConnection());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        try {
            int userId = (int) session.getAttribute("user_id");
            int eventId = Integer.parseInt(request.getParameter("event_id"));
            int numberOfPeople = Integer.parseInt(request.getParameter("number_of_people"));

            Booking booking = new Booking(userId, eventId, numberOfPeople);
            boolean success = bookingDAO.createBooking(booking);

            if (success) {
                response.sendRedirect("customer-dashboard.jsp?message=BookingSuccessful");
            } else {
                response.sendRedirect("booking.jsp?error=BookingFailed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("booking.jsp?error=InvalidInput");
        }
    }
}
