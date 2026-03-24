<cfif NOT structKeyExists(session,"userID") OR session.role NEQ "user">
    <cfset structClear(session)>
<cflocation url="../login.cfm" addtoken="false">
</cfif>

<cfset customerID = session.userID>




<cfquery name="getCustomer" datasource="securitydb">
    SELECT name,email
    FROM Users
    WHERE id =
    <cfqueryparam value="#customerID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfset customerName = getCustomer.name>
<cfset customerEmail = getCustomer.email>



<cfquery name="getProducts" datasource="storedb">
    SELECT id,ProductName
    FROM Products
    ORDER BY ProductName
</cfquery>



<cfquery name="admins" datasource="securitydb">
    SELECT email
    FROM Users
    WHERE roleID = 1
</cfquery>

<cfset adminEmails = "">

<cfloop query="admins">
    <cfset adminEmails = listAppend(adminEmails,email)>
</cfloop>




<cfif structKeyExists(form,"submitFeedback")>

    <cfif len(trim(form.productID)) AND len(trim(form.message))>


        <cfquery name="productInfo" datasource="storedb">
        SELECT ProductName
        FROM Products
        WHERE id =
        <cfqueryparam value="#form.productID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfset productName = productInfo.ProductName>


        

        <cfoutput>

            <cfmail
            to="#adminEmails#"
            from="noreply@customer.com"
            subject="Product Feedback"
            server="smtp.yopmail.com"
            port="25"
            type="html">

                <h3>New Product Feedback</h3>

                <b>Customer:</b> #customerName# <br>
                <b>Email:</b> #customerEmail# <br><br>

                <b>Product:</b> #productName# <br><br>

                <b>Message:</b><br>
                #form.message#

            </cfmail>

        </cfoutput>

        <cfset successMsg = "Feedback sent successfully. Thank you!">

    <cfelse>

        <cfset errorMsg = "Please select product and write message.">

    </cfif>

</cfif>


<!DOCTYPE html>
<html>

<head>

<title>Product Feedback</title>

<style>

    body{
    font-family:'Segoe UI';
    background:#f4f6f9;
    margin:0;
    }

    .container{
    width:40%;
    margin:70px auto;
    }

    .card{
    background:white;
    padding:30px;
    border-radius:14px;
    box-shadow:0 8px 20px rgba(0,0,0,0.05);
    }

    h2{
    margin-bottom:20px;
    }

    .form-group{
    margin-bottom:15px;
    }

    label{
    font-weight:600;
    font-size:14px;
    }

    input,select,textarea{
    width:100%;
    padding:10px;
    border:1px solid #ddd;
    border-radius:6px;
    margin-top:5px;
    }

    textarea{
    height:120px;
    resize:none;
    }

    button{
    background:#2563eb;
    color:white;
    border:none;
    padding:10px 15px;
    border-radius:6px;
    cursor:pointer;
    font-weight:600;
    }

    button:hover{
    background:#1e40af;
    }

    .success{
    color:green;
    margin-bottom:15px;
    }

    .error{
    color:red;
    margin-bottom:15px;
    }

</style>

</head>


<body>

    <cfinclude template="../includes/header.cfm">

    <div class="container">

        <div class="card">

            <h2>Product Feedback</h2>

            <cfif structKeyExists(variables,"successMsg")>
                <div class="success">
                    <cfoutput>#successMsg#</cfoutput>
                </div>
            </cfif>

            <cfif structKeyExists(variables,"errorMsg")>
                <div class="error">
                    <cfoutput>#errorMsg#</cfoutput>
                </div>
            </cfif>


            <form method="post">

                <div class="form-group">

                    <label>Select Product</label>

                    <select name="productID" required>

                        <option value="">Select Product</option>

                        <cfoutput query="getProducts">
                            <option value="#id#">#ProductName#</option>
                        </cfoutput>

                    </select>

                </div>


                <div class="form-group">

                    <label>Your Message</label>

                    <textarea name="message" required></textarea>

                </div>


                <input type="hidden" name="submitFeedback" value="1">

                <button type="submit">
                    Send Feedback
                </button>

            </form>

        </div>

    </div>

    <cfinclude template="../includes/footer.cfm">

</body>
</html>