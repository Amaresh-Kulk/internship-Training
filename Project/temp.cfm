<!---<!DOCTYPE html>
<html>
<head>
    <title>Convert Passwords</title>
</head>
<body>

<h3>Convert Plain Passwords to SHA-256</h3>

<cfif structKeyExists(form, "convert")>

    <cfquery name="getUsers" datasource="EcommerceDB">
        SELECT id, password
        FROM Users
    </cfquery>

    <cfloop query="getUsers">

        <!--- Hash current password --->
        <cfset newPassword = hash(getUsers.password, "SHA-256")>

        <!--- Prepare form fields for cfupdate --->
        <cfset form.id = getUsers.id>
        <cfset form.password = newPassword>

        <!--- Update using cfupdate --->
        <cfupdate datasource="EcommerceDB" tablename="Users" formfields="form.id, form.password">

    </cfloop>

    <p style="color:green;">All passwords converted successfully.</p>

</cfif>

<form method="post">
    <input type="submit" name="convert" value="Convert Passwords">
</form>

</body>
</html>


<cfset path = "/uploads/profileImages/image.jpg">
<img src="/EcommerceOSS/uploads/profileImages/image.jpg" height="30rem" width="30rem">
<img src=#path#>
<!---<img src="http://localhost/uploads/profileImages/image.jpg">--->

<!--- Handle Image Upload --->
<cfif structKeyExists(form, "uploadImage")>

    <cfset productID = form.productID>

    <cffile 
        action="upload"
        fileField="product_image"
        destination="#expandPath('./uploads/products/')#"
        nameConflict="makeunique"
        accept="image/jpeg,image/png,image/jpg"
    >

    <cfset imagePath = "/EcommerceOSS/uploads/products/c1.jpg" >

    <cfquery datasource="EcommerceDB">
        UPDATE Products
        SET image_path = <cfqueryparam value="#imagePath#" cfsqltype="cf_sql_varchar">
        WHERE id = <cfqueryparam value="#productID#" cfsqltype="cf_sql_integer">
    </cfquery>

</cfif>


<!--- Fetch All Products --->
<cfquery name="getProducts" datasource="EcommerceDB">
    SELECT * FROM Products
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Products</title>
    <style>
        body { font-family: Arial; background: #f4f4f4; }
        table {
            width: 95%;
            margin: 30px auto;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: black;
            color: white;
        }
        img {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .upload-btn {
            padding: 5px;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Manage Products</h2>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Description</th>
    <th>Category</th>
    <th>Gender</th>
    <th>Price</th>
    <th>Qty</th>
    <th>Image</th>
    <th>Upload Image</th>
</tr>

<cfoutput query="getProducts">
<tr>
    <td>#id#</td>
    <td>#ProductName#</td>
    <td>#description#</td>
    <td>#categoryID#</td>
    <td>#Gender#</td>
    <td>Rs.#Price#</td>
    <td>#Quantity#</td>

    <!--- Show Image --->
    <td>
        <cfif len(trim(image_path))>
            <img src="<cfoutput >#image_path#</cfoutput>">
        <cfelse>
            No Image
        </cfif>
    </td>

    <!--- Upload Form --->
    <td>
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="productID" value="#id#">
            <input type="file" name="product_image" required>
            <input type="submit" name="uploadImage" value="Upload" class="upload-btn">
        </form>
    </td>

</tr>
</cfoutput>

</table>

</body>
</html>


    <cfmail 
        to="rabommanausei-3875@yopmail.com"
        from="braleugeuppacei-5529@yopmail.com"
        subject="Welcome to Our Store"
        
        type="html">

        <h2>Welcome 123</h2>
        <p>Your account has been created successfully.</p>
        <p>You can now login to the system.</p>

    </cfmail>



<cfoutput >
    sent mail

</cfoutput>--->
<!--- UPDATE USER 
<cfif structKeyExists(form,"updateUser")>

    <cfquery datasource="EcommerceDB">
    UPDATE Users
    SET name =
        <cfqueryparam value="#form.name#" cfsqltype="cf_sql_varchar">,
        email =
        <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
        roleID =
        <cfqueryparam value="#form.roleID#" cfsqltype="cf_sql_integer">
    WHERE id =
        <cfqueryparam value="#form.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfquery datasource="EcommerceDB">
    UPDATE Customer
    SET first_name =
        <cfqueryparam value="#form.first_name#" cfsqltype="cf_sql_varchar">,
        last_name =
        <cfqueryparam value="#form.last_name#" cfsqltype="cf_sql_varchar">,
        phone =
        <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_varchar">
    WHERE id =
        <cfqueryparam value="#form.userID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfset successMsg = "User updated successfully.">

</cfif>


<!--- GET USERS --->

<cfquery name="getUsers" datasource="EcommerceDB">
SELECT 
u.id,
u.name,
u.email,
u.roleID,
r.role,
c.first_name,
c.last_name,
c.phone
FROM Users u
INNER JOIN Roles r ON r.id = u.roleID
LEFT JOIN Customer c ON c.id = u.id
ORDER BY u.id
</cfquery>


<!--- GET ROLES --->

<cfquery name="getRoles" datasource="EcommerceDB">
SELECT * FROM Roles
</cfquery>



<!DOCTYPE html>
<html>
<head>

<title>Manage Users</title>

<style>

body{
font-family:'Segoe UI';
background:#f4f6f9;
margin:0;
}

.container{
width:90%;
margin:40px auto;
}

table{
width:100%;
border-collapse:collapse;
background:white;
box-shadow:0 10px 25px rgba(0,0,0,0.05);
}

th,td{
padding:12px;
border-bottom:1px solid #eee;
text-align:left;
}

th{
background:#1e40af;
color:white;
}

input,select{
padding:6px;
border:1px solid #ddd;
border-radius:6px;
width:100%;
}

button{
background:#2563eb;
color:white;
border:none;
padding:8px 14px;
border-radius:6px;
cursor:pointer;
}

.success{
color:green;
margin-bottom:15px;
}

</style>

</head>

<body>

<div class="container">

<h2>Manage Users</h2>

<cfif structKeyExists(variables,"successMsg")>
<div class="success">
<cfoutput>#successMsg#</cfoutput>
</div>
</cfif>

<table>

<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>First Name</th>
<th>Last Name</th>
<th>Phone</th>
<th>Role</th>
<th>Action</th>
</tr>

<cfoutput query="getUsers">

<form method="post">

<tr>

<td>#id#</td>

<td>
<input type="text" name="name" value="#name#">
</td>

<td>
<input type="email" name="email" value="#email#">
</td>

<td>
<input type="text" name="first_name" value="#first_name#">
</td>

<td>
<input type="text" name="last_name" value="#last_name#">
</td>

<td>
<input type="text" name="phone" value="#phone#">
</td>

<td>

<select name="roleID">

<cfloop query="getRoles">

<option value="#id#" <cfif getRoles.id EQ getUsers.roleID>selected</cfif>>
#role#
</option>

</cfloop>

</select>

</td>

<td>

<input type="hidden" name="userID" value="#getUsers.id#">
<input type="hidden" name="updateUser" value="1">

<button type="submit">Update</button>

</td>

</tr>

</form>

</cfoutput>

</table>

</div>

</body>
</html>


--->

<cfmail to="bragrubrauyoquou-9187@yopmail.com" 
from="chaitunomula1@gmail.com" 
subject="Welcome to Bedrock" 
type="text"> 
Dear hello 
We would like to thank you for joining. 
Best wishes 
Chaitanya 1111111
</cfmail> 
<cfoutput> 
<p>Thank you  for registdewddccvergtrfdering. 
We have just sent you an email.</p> 
</cfoutput> 