<%-- 
    Document   : consultaColaboradores
    Created on : 25/11/2018, 06:49:16 PM
    Author     : benja
--%>

<%@page import="impDao.impColaboradorDao"%>
<%@page import="dao.iColaboradorDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        iColaboradorDao col = new impColaboradorDao();
        col.consultaColabBoleta(2017090841);
        
        %>
    </body>
</html>
