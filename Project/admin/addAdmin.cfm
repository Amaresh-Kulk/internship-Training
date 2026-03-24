<!-- HANDLE FORM -->
<cfif structKeyExists(form,"createAdmin")>

    <cfset email = trim(form.email)>
    <cfset name  = trim(form.name)>

    <cfif name EQ "" OR email EQ "" OR trim(form.password) EQ "">
        <cfset errorMsg = "All fields are required.">

    <cfelse>

        <!-- Check duplicate email -->
        <cfquery name="checkEmail" datasource="securitydb">
            SELECT id FROM Users
            WHERE email =
            <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif checkEmail.recordCount GT 0>

            <cfset errorMsg = "Email already exists.">

        <cfelse>

            <!-- Get admin role -->
            <cfquery name="getRole" datasource="securitydb">
                SELECT id FROM Roles WHERE role = 'admin'
            </cfquery>

            <!-- Hash password -->
            <cfset hashedPassword = hash(form.password,"SHA-256")>

            <!-- Insert admin -->
            <cfquery datasource="securitydb">
                INSERT INTO Users (name,email,password,roleID)
                VALUES (
                    <cfqueryparam value="#name#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#getRole.id#" cfsqltype="cf_sql_integer">
                )
            </cfquery>

            <!-- SEND EMAIL -->
            <cfmail
                to="#email#"
                from="noreply@store.com"
                subject="Admin Account Created"
                server="smtp.yopmail.com"
                port="25"
                type="html">

                <h2>Welcome to EcommerceOSS</h2>

                <p>Hello #name#,</p>

                <p>Your <b>Admin Account</b> has been created successfully.</p>

                <p><b>Login Details:</b></p>

                Email: #email# <br>
                Password: #form.password# <br>

                <br>

                <p>Please login and change your password immediately.</p>

            </cfmail>

            <cfset successMsg = "Admin created successfully & email sent.">

        </cfif>

    </cfif>

</cfif>

<cfif structKeyExists(variables,"successMsg")>
    <cfset form.name = "">
    <cfset form.email = "">
    <cfset form.password = "">
</cfif>

<!DOCTYPE html>
<html>
<head>

    <title>Add Admin</title>

    <style>
        body {
            font-family:Segoe UI;
            background:#f4f6f9;
        }

        .box {
            width:400px;
            margin:80px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0 10px 25px rgba(0,0,0,0.08);
        }

        h2 {
            text-align:center;
            margin-bottom:20px;
        }

        input {
            width:100%;
            padding:10px;
            margin:10px 0;
            border-radius:6px;
            border:1px solid #ddd;
        }

        input:focus {
            border-color:#2563eb;
            outline:none;
        }

        .error {
            color:red;
            font-size:13px;
            text-align:center;
        }

        .success {
            color:green;
            text-align:center;
        }

        .btn {
            background:#2563eb;
            color:white;
            padding:12px;
            border:none;
            width:100%;
            border-radius:6px;
            font-weight:600;
        }

        .invalid {
            border:1px solid red;
        }

        .valid {
            border:1px solid green;
        }
    </style>

</head>

<body>
    <cfinclude template="../includes/header.cfm">


    <div class="box">

        <h2>Add Admin</h2>

        <cfif structKeyExists(variables,"errorMsg")>
            <div class="error"><cfoutput>#errorMsg#</cfoutput></div>
        </cfif>

        <cfif structKeyExists(variables,"successMsg")>
            <div class="success"><cfoutput>#successMsg#</cfoutput></div>
        </cfif>

        <form method="post" onsubmit="return validateForm()" autocomplete="off">
            <input type="text" style="display:none">
            <input type="password" style="display:none">

            <input type="text" id="name" name="name" placeholder="Full Name" autocomplete="off">
            <small id="nameErr" class="error"></small>

            <input type="email" id="email" name="email" placeholder="Email" autocomplete="off">
            <small id="emailErr" class="error"></small>

            <input type="password" id="password" name="password" placeholder="Password" autocomplete="off">
            <small id="passErr" class="error"></small>

            <button type="submit" name="createAdmin" class="btn">Create Admin</button>

        </form>

    </div>
    <cfinclude template="../includes/footer.cfm">
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("email").value = "";
            document.getElementById("password").value = "";
        });

        const name = document.getElementById("name");
        const email = document.getElementById("email");
        const password = document.getElementById("password");

        let emailExists = false;

        // Name
        name.addEventListener("input", () => {
            if (name.value.trim().length < 3) {
                nameErr.innerText = "Minimum 3 characters";
                name.classList.add("invalid");
            } else {
                nameErr.innerText = "";
                name.classList.remove("invalid");
                name.classList.add("valid");
            }
        });

        // Email + AJAX check
        email.addEventListener("input", () => {

            const val = email.value;

            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val)) {
                emailErr.innerText = "Invalid email";
                return;
            }

            fetch(`/EcommerceOSS/api/checkEmail.cfm?email=${encodeURIComponent(val)}`)
                .then(res => res.json())
                .then(data => {

                    if (data.exists) {
                        emailErr.innerText = "Email already exists";
                        email.classList.add("invalid");
                        emailExists = true;
                    } else {
                        emailErr.innerText = "";
                        email.classList.remove("invalid");
                        email.classList.add("valid");
                        emailExists = false;
                    }

                });
        });

        // Password
        password.addEventListener("input", () => {
            if (password.value.length < 6) {
                passErr.innerText = "Minimum 6 characters";
                password.classList.add("invalid");
            } else {
                passErr.innerText = "";
                password.classList.remove("invalid");
                password.classList.add("valid");
            }
        });

        // Final validation
        function validateForm() {
            if (emailExists) return false;

            return (
                name.value.trim().length >= 3 &&
                password.value.length >= 6
            );
        }
    </script>
</body>
</html>