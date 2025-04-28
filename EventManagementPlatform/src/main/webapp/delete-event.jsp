<%@ page import="event.EventDAO, event.DBConnection" %>
<%
    int eventId = Integer.parseInt(request.getParameter("event_id"));
    EventDAO eventDAO = new EventDAO(DBConnection.getConnection());
    eventDAO.deleteEvent(eventId);
    response.sendRedirect("admin-dashboard.jsp");
%>
