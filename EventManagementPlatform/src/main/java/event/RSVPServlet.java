package event;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RSVPServlet")
public class RSVPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RSVPDAO rsvpDAO;

    @Override
    public void init() {
        try {
            rsvpDAO = new RSVPDAO(DBConnection.getConnection());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Don't create a new session

        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp?error=SessionExpired");
            return;
        }

        int eventId;
        int userId;
        String status;

        try {
            eventId = Integer.parseInt(request.getParameter("event_id"));
            userId = (int) session.getAttribute("user_id");
            status = request.getParameter("status");

            // Validate the status
            if (status == null || status.isEmpty() || 
                (!status.equals("Going") && !status.equals("Not Going") && !status.equals("Maybe"))) {
                request.setAttribute("error", "Invalid RSVP status.");
                request.getRequestDispatcher("customer-dashboard.jsp").forward(request, response);
                return;
            }

            boolean success = rsvpDAO.addRSVP(eventId, userId, status);

            if (success) {
                response.sendRedirect("customer-dashboard.jsp");
            } else {
                request.setAttribute("error", "RSVP failed.");
                request.getRequestDispatcher("customer-dashboard.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Event ID.");
            request.getRequestDispatcher("customer-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong.");
            request.getRequestDispatcher("customer-dashboard.jsp").forward(request, response);
        }
    }
}
