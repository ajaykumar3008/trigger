<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Multi-Form Page</title>
    <style>
        .tab-container {
            width: 100%;
            margin: 0 auto;
        }

        .tabs {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
        }

        .tabs li {
            margin-right: 10px;
        }

        .tab-content {
            display: none;
            width: 80%;
            margin: 20px auto;
        }

        .active {
            display: block;
        }
    </style>
</head>
<body>
    <div class="tab-container">
        <ul class="tabs">
            <li><a href="#form1">Form 1</a></li>
            <li><a href="#form2">Form 2</a></li>
            <li><a href="#form3">Form 3</a></li>
        </ul>

        <form id="form1" class="tab-content active" action="http://localhost:8081/LoanManagement/applicant" method="get">
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" class="form-control" name="cust_firstname" placeholder="Enter First Name">
                <label for="lastName">Last Name:</label>
                <input type="text" class="form-control" name="cust_lastname" placeholder="Enter Last Name">
            </div>

            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" class="form-control" name="cust_dob">
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
            <button type="submit">button</button>
        </form>

        <form id="form2" class="tab-content" action="http://localhost:8081/LoanManagement/loan" method="get">
           <h1 class="display-4">Loan Application Form</h1>
        
        	<%-- Java code to get the current date --%>
            <%
                java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                java.util.Date currentDate = new java.util.Date();
                String formattedDate = dateFormat.format(currentDate);
            %>

            <div class="form-group">
                <label for="applicationDate">Application Date:</label>
                <input type="text" class="form-control" name="applicationDate" id="applicationDate" value="<%= formattedDate %>" readonly>
            </div>

            <div class="form-group">

                <label for="loanType">Loan Type:</label>
                <select class="form-control" name="loanTypeID" id="loanType">
                    <option value="1">Personal Loan</option>
                    <option value="2">Home Loan</option>
                    <option value="3">Vehicle Loan</option>
                    <!-- Add more loan types as needed -->
                </select>
            </div>

            <div class="form-group">
                <label for="amountRequired">Amount Required:</label>
                <input type="text" class="form-control" name="amountRequired" id="amountRequired" required>
            </div>

            <div class="form-group">
                <label for="numMonths">Number of Months:</label>
                <input type="text" class="form-control" name="monthsRequired" id="numMonths" required>
            </div>
			<div class="form-group">
                <label for="annualincome">Annual Income:</label>
                <input type="text" class="form-control" name="annualincome" id="annualincome" required>
            </div>
            <div class="form-group">
                <label for="disposalincome">Disposal Income:</label>
                <input type="text" class="form-control" name="disposalincome" id="disposalincome" required>
            </div>
            <button type="submit">Next</button>
        </form>

        <form id="form3" class="tab-content" action="http://localhost:8081/LoanManagement/nominee" method="get">
           <div class="form-group">
                <label for="name">Nominee Name:</label>
                <input type="text" class="form-control" name="name" id="name">
            </div>
            <div class="form-group">
                <label for="ralation">Nominee Relation:</label>
                <input type="text" class="form-control" name="relation" placeholder="Enter PAN No" id="relation">
            </div>
            <button type="submit">Submit</button>
        </form>

     
    </div>
<script>
    let currentTab = 0;

    function openTab(evt, tabName) {
        const tabs = document.getElementsByClassName("tab");
        for (let i = 0; i < tabs.length; i++) {
            tabs[i].style.display = "none";
        }
        document.getElementById(tabName).style.display = "block";
    }

    function submitForm(formId) {
        const formData = new FormData(document.getElementById(formId));
        // Here, you can send the form data to your server using AJAX or other methods.
        console.log("Form data submitted:", formData);
    }

    function submitFormAndNext(nextTabName, formId) {
        submitForm(formId);
        nextTab(nextTabName);
    }

    function nextTab(tabName) {
        const tabs = document.getElementsByClassName("tab");
        if (currentTab < tabs.length - 1) {
            tabs[currentTab].style.display = "none";
            currentTab++;
            openTab(null, tabName);
        }
    }

    function prevTab(tabName) {
        const tabs = document.getElementsByClassName("tab");
        if (currentTab > 0) {
            tabs[currentTab].style.display = "none";
            currentTab--;
            openTab(null, tabName);
        }
    }

    // Show the initial tab
    openTab(null, 'tab1');
</script>

</body>
</html>
