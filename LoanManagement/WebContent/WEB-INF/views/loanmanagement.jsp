<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Reset some default styles for the page */
        body, ul {
            margin: 0;
            padding: 0;
        }

        /* Style for the menu */
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

        /* Style for the content */
        .content {
            margin-left: 220px; 
            padding: 20px;
        }

        /* Example styles for the content area */
        .content h1 {
            font-size: 24px;
        }

        .content p {
            font-size: 16px;
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
        
        
    </div>
</body>
</html>
