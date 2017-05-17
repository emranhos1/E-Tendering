<%-- 
    Document   : logout
    Created on : Mar 20, 2017, 3:53:59 PM
    Author     : Md. Emran Hossain
--%>
<%
    session.setAttribute("idUser", null);
    session.invalidate();
    response.sendRedirect("index.jsp");
%>