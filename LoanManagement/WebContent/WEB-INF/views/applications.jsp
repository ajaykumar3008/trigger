<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,loanmanagement.*" %>
<% List<Loan> appList = (List<Loan>) request.getAttribute("applications"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body, ul {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        /* Apply a background color to the entire page */
        body {
            background-color: #f0f0f0;
        }

        /* Styling for the menu */
        .menu {
            background-color: #333;
            color: white;
            width: 200px; /* Adjust the width as needed */
            height: 100%; /* Full height menu */
            position: fixed;
            top: 0;
            left: 0;
        }

        .menu ul {
            list-style-type: none;
            padding: 20px;
        }

        .menu ul li {
            margin-bottom: 10px;
        }

        .menu a {
            color: white;
            text-decoration: none;
        }

        /* Styling for the content area */
        .content {
        	margin-top:30px;
            margin-left: 220px; 
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .content h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Styling for the table */
        table {
        margin-top:30px;
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border: 1px solid #ddd;
            background-color: #fff;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        /* Style odd rows with a light gray background */
        tr:nth-child(odd) {
            background-color: #f2f2f2;
        }

        /* Style even rows with a white background */
        tr:nth-child(even) {
            background-color: #ffffff;
        }

        /* Styling for the table header */
        th {
            background-color: #333;
            color: white;
        }

        /* Add some space for the last column with the button */
        td:last-child {
            padding-right: 30px;
        }

        /* Style the button */
        .btn {
            background-color: #007BFF;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
    <title>Left Top Menu Page</title>
</head>
<body>
    <div class="menu">
        <ul>
            <li><a href="http://localhost:8081/LoanManagement/applications">Loan Applicants</a></li>
            <li><a href="#">Loans</a></li>
            <li><a href="#">Repayments</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
    </div>
    <div class="content">
        <h1>Loan Applications</h1>
        <table>
            <tr>
                <th><h3>Name</h3></th>
                <th><h3>Loan Type</h3></th>
                <th><h3>Amount</h3></th>
                <th><h3>Months</h3></th>
                <th></th>
            </tr>
            <% for (Loan loan : appList) { %>
                <tr>
                    <td><%= loan.getApplicationDate() %></td>
                    <td><%= loan.getAmountRequired() %></td>
                    <td><%= loan.getLoanTypeID() %></td>
                    <td><%= loan.getMonthsRequired() %></td>
                    <td><a class="btn" href="http://localhost:8081/LoanManagement/applicant?applicant=">Details</a></td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
