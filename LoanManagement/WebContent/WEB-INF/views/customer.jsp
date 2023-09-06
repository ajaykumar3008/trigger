<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Information</title>
    <!-- Add Bootstrap CSS link here -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Customer Information</h2>
        <form action="http://localhost:8083/LoanManagement/loan" method="get">


            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" class="form-control" name="cust_firstname" placeholder="Enter First Name">
                <label for="lastName">Last Name:</label>
                <input type="text" class="form-control" name="cust_lastname" placeholder="Enter Last Name">
            </div>

            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="text" class="form-control" name="cust_dob">
            </div>
            <div class="form-group">
                <label for="panNo">PAN No:</label>
                <input type="text" class="form-control" name="cust_panno" placeholder="Enter PAN No">
            </div>
            <div class="form-group">
                <label for="mobileNo">Mobile No:</label>
                <input type="text" class="form-control" name="cust_mobile" placeholder="Enter Mobile No">
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea class="form-control" name="cust_address" rows="3" placeholder="Enter Address"></textarea>
            </div>
            <div class="form-group">
                <label for="guardianName">Guardian Name:</label>
                <input type="text" class="form-control" name="cust_gname" placeholder="Enter Guardian Name">
            </div>
            
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>

    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>