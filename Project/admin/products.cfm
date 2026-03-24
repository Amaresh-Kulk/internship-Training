
<cfset adminID = session.userID>




<cfif structKeyExists(form,"action") AND form.action EQ "add">

    <cfset imagePath="">

    <cfif structKeyExists(form,"productImage") AND len(form.productImage)>

        <cffile 
        action="upload"
        filefield="productImage"
        destination="#expandPath('/EcommerceOSS/uploads/products/')#"
        nameconflict="makeunique">

        <cfset imagePath="uploads/products/#cffile.serverFile#">

    </cfif>

    <cfquery datasource="storedb">

        INSERT INTO Products
        (ProductName,description,categoryID,Gender,Price,Quantity,image_path)

        VALUES(

        <cfqueryparam value="#form.ProductName#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.categoryID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#form.Gender#" cfsqltype="cf_sql_varchar" null="#NOT len(form.Gender)#">,
        <cfqueryparam value="#form.Price#" cfsqltype="cf_sql_decimal">,
        <cfqueryparam value="#form.Quantity#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#imagePath#" cfsqltype="cf_sql_varchar">

        )

    </cfquery>



    <cfquery name="newProduct" datasource="storedb">
        SELECT TOP 1 id FROM Products ORDER BY id DESC
    </cfquery>

    <cfquery datasource="storedb">

        INSERT INTO InventoryLogs
        (productID,adminID,actionType,description,actionTime)

        VALUES(

        <cfqueryparam value="#newProduct.id#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#adminID#" cfsqltype="cf_sql_integer">,
        'ADD',
        'Product added',
        GETDATE()

        )

    </cfquery>

    <cflocation url="products.cfm" addtoken="false">

</cfif>




<cfif structKeyExists(form,"action") AND form.action EQ "update">

<cfset imagePath=form.oldImage>

    <cfif structKeyExists(form,"productImage") AND len(form.productImage)>

        <cffile 
        action="upload"
        filefield="productImage"
        destination="#expandPath('/EcommerceOSS/uploads/products/')#"
        nameconflict="makeunique">

        <cfset imagePath="uploads/products/#cffile.serverFile#">

    </cfif>

    <cfquery datasource="storedb">

        UPDATE Products

        SET
        ProductName =
        <cfqueryparam value="#form.ProductName#" cfsqltype="cf_sql_varchar">,

        description =
        <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">,

        categoryID =
        <cfqueryparam value="#form.categoryID#" cfsqltype="cf_sql_integer">,

        Gender =
        <cfqueryparam value="#form.Gender#" cfsqltype="cf_sql_varchar" null="#NOT len(form.Gender)#">,

        Price =
        <cfqueryparam value="#form.Price#" cfsqltype="cf_sql_decimal">,

        Quantity =
        <cfqueryparam value="#form.Quantity#" cfsqltype="cf_sql_integer">,

        image_path =
        <cfqueryparam value="#imagePath#" cfsqltype="cf_sql_varchar">

        WHERE id =
        <cfqueryparam value="#form.productID#" cfsqltype="cf_sql_integer">

    </cfquery>



    <cfquery datasource="storedb">

        INSERT INTO InventoryLogs
        (productID,adminID,actionType,description,actionTime)

        VALUES(

        <cfqueryparam value="#form.productID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#adminID#" cfsqltype="cf_sql_integer">,
        'UPDATE',
        'Product updated',
        GETDATE()

        )

    </cfquery>

    <cflocation url="products.cfm" addtoken="false">

</cfif>




<cfif structKeyExists(url,"deleteID")>

    <cfset productID = url.deleteID>

    <cfquery datasource="storedb">
        INSERT INTO InventoryLogs
        (productID,adminID,actionType,description,actionTime)
        VALUES(
        <cfqueryparam value="#productID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#adminID#" cfsqltype="cf_sql_integer">,
        'DELETE',
        'Product deleted',
        GETDATE()
        )
    </cfquery>

    <cfquery datasource="storedb">
        UPDATE Products
        SET isDeleted = 1
        WHERE id =
        <cfqueryparam value="#productID#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cflocation url="products.cfm" addtoken="false">

</cfif>




<cfquery name="getCategories" datasource="storedb">
    SELECT * FROM categories
</cfquery>

<cfquery name="getProducts" datasource="storedb">

    SELECT p.*,c.categoryName
    FROM Products p
    LEFT JOIN categories c
    ON c.id = p.categoryID
    WHERE isDeleted = 0

</cfquery>



<!DOCTYPE html>
<html>

<head>

    <title>Product Management</title>

<style>

    body{
    font-family:'Segoe UI',sans-serif;
    background:#f1f5f9;
    margin:0;
    }

    .container{
    width:92%;
    margin:70px auto;
    }

    .header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
    }

    .header h2{
    margin:0;
    font-size:26px;
    font-weight:600;
    color:#111827;
    }

    /* Buttons */

    button{
    background:#2563eb;
    color:white;
    border:none;
    padding:10px 18px;
    border-radius:8px;
    cursor:pointer;
    font-weight:600;
    font-size:14px;
    transition:0.2s;
    }

    button:hover{
    background:#1e40af;
    }

    .deleteBtn{
    background:#dc2626;
    padding:8px 12px;
    border-radius:6px;
    text-decoration:none;
    color:white;
    font-size:13px;
    }

    .deleteBtn:hover{
    background:#991b1b;
    }

    /* Cards */

    .card{
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 10px 25px rgba(0,0,0,0.05);
    margin-bottom:30px;
    }

    /* Form */

    .grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px;
    margin-bottom:10px;
    }

    input,select,textarea{
    width:100%;
    padding:10px;
    border:1px solid #d1d5db;
    border-radius:8px;
    font-size:14px;
    background:white;
    }

    textarea{
    resize:none;
    height:80px;
    }

    input:focus,select:focus,textarea:focus{
    outline:none;
    border-color:#2563eb;
    box-shadow:0 0 0 2px rgba(37,99,235,0.15);
    }

    /* Table */

    table{
    width:100%;
    border-collapse:collapse;
    font-size:14px;
    }

    th{
    background:#f3f4f6;
    font-weight:600;
    }

    th,td{
    padding:12px;
    border-bottom:1px solid #e5e7eb;
    text-align:center;
    }

    tr:hover{
    background:#f9fafb;
    }

    /* Product Image */

    img{
    width:55px;
    height:55px;
    object-fit:cover;
    border-radius:8px;
    border:1px solid #eee;
    }

    /* Actions */

    .actions{
    display:flex;
    gap:10px;
    justify-content:center;
    align-items:center;
    }

    /* Update button */

    .actions button{
    background:#16a34a;
    padding:7px 14px;
    font-size:13px;
    }

    .actions button:hover{
    background:#166534;
    }
</style>

</head>

<body>

    <cfinclude template="../includes/header.cfm">

    <div class="container">

    <div class="header">

        <h2>Product Management</h2>

        <cfif structKeyExists(url,"add")>
            <a href="products.cfm">
            <button type="button">Cancel Product</button>
            </a>
        <cfelse>
            <a href="products.cfm?add=1">
                <button type="button">Add Product</button>
            </a>
        </cfif>

    </div>



    <!-- ================= ADD PRODUCT FORM ================= -->

    <cfif structKeyExists(url,"add")>

        <div class="card">

            <h3>Add New Product</h3>

            <form method="post" enctype="multipart/form-data">

                <input type="hidden" name="action" value="add">

                <div class="grid">

                    <input type="text" name="ProductName" placeholder="Product Name" required>

                    <select name="categoryID" required>
                        <cfoutput query="getCategories">
                            <option value="#id#">#categoryName#</option>
                        </cfoutput>
                    </select>

                    <select name="Gender">
                        <option value="">Select Gender (Optional)</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Unisex">Unisex</option>
                    </select>

                    <input type="number" name="Price" placeholder="Price" required>

                    <input type="number" name="Quantity" placeholder="Quantity" required>

                    <input type="file" name="productImage" required>

                </div>

                <br>

                <textarea name="description" placeholder="Description" required></textarea>

                <br><br>

                <button type="submit">Add Product</button>

            </form>

        </div>

    </cfif>



    
    <cfif NOT structKeyExists(url,"add")>

        <div class="card">

        <table>

            <tr>

                <th>Image</th>
                <th>Name</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Category</th>
                <th>Gender</th>
                <th>Change Image</th>
                <th>Actions</th>

            </tr>


            <cfoutput query="getProducts">

                <form method="post" enctype="multipart/form-data"
                onsubmit="return confirm('Are you sure you want to update this product?');">

                    <tr>

                        <td>
                            <img src="/EcommerceOSS/#image_path#">
                        </td>

                        <td>
                            <input type="text" name="ProductName" value="#ProductName#" required>
                        </td>

                        <td>
                            <input type="number" name="Price" value="#Price#" required>
                        </td>

                        <td>
                            <input type="number" name="Quantity" value="#Quantity#" required>
                        </td>

                        <td>

                            <select name="categoryID">

                                <cfloop query="getCategories">

                                    <option value="#getCategories.id#"
                                        <cfif getCategories.id EQ categoryID>selected</cfif>>

                                            #getCategories.categoryName#

                                    </option>

                                </cfloop>

                            </select>

                        </td>

                        <td>

                            <select name="Gender">
                                <option value="">None</option>
                                <option value="Male" <cfif Gender EQ "Male">selected</cfif>>Male</option>
                                <option value="Female" <cfif Gender EQ "Female">selected</cfif>>Female</option>
                                <option value="Unisex" <cfif Gender EQ "Unisex">selected</cfif>>Unisex</option>
                            </select>

                        </td>

                        <td>
                            <input type="file" name="productImage">
                        </td>

                        <td>

                            <div class="actions">

                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productID" value="#id#">
                                <input type="hidden" name="description" value="#description#">
                                <input type="hidden" name="oldImage" value="#image_path#">

                                <button type="submit">Update</button>

                                <a class="deleteBtn"
                                href="products.cfm?deleteID=#id#"
                                onclick="return confirm('Delete product?')">

                                    Delete

                                </a>

                            </div>

                        </td>

                    </tr>

                </form>

            </cfoutput>

        </table>

        </div>

    </cfif>

    </div>

    <cfinclude template="../includes/footer.cfm">

</body>
</html>