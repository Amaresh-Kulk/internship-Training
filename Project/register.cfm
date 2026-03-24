<!-- BACKEND (unchanged logic) -->
<cfif structKeyExists(form, "submit")>

    <cfif trim(form.first_name) EQ "">
        <cfset errorMsg = "First Name is required.">
    <cfelse>

        <cfquery name="checkEmail" datasource="securitydb">
            SELECT id FROM Users WHERE email =
            <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif checkEmail.recordCount GT 0>
            <cfset errorMsg = "Email already registered.">
        <cfelse>
            <cfset fullName = trim(form.first_name)>
            <cfif trim(form.last_name) NEQ "">
                <cfset fullName &= " " & trim(form.last_name)>
            </cfif>

            <cfset hashedPassword = hash(form.password, "SHA-256")>

            <cfquery name="getRole" datasource="securitydb">
                SELECT id FROM Roles WHERE role = 'user'
            </cfquery>

            <cfquery datasource="securitydb">
                INSERT INTO Users (name,email,password,roleID)
                VALUES (
                    <cfqueryparam value="#fullName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#getRole.id#" cfsqltype="cf_sql_integer">
                )
            </cfquery>

            <cfquery name="getNewUser" datasource="securitydb">
                SELECT TOP 1 id FROM Users
                WHERE email =
                <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
                ORDER BY id DESC
            </cfquery>

            <cfquery datasource="customerdb">
                INSERT INTO Customer (id,first_name,last_name,phone)
                VALUES (
                    <cfqueryparam value="#getNewUser.id#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#form.first_name#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.last_name#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#form.phone#" cfsqltype="cf_sql_varchar">
                )
            </cfquery>

            <cflocation url="login.cfm" addtoken="false">

        </cfif>
    </cfif>
</cfif>

<!DOCTYPE html>
<html>
<head>

    <title>Create Account</title>

    <style>
        body {
            font-family:Segoe UI;
            background:linear-gradient(135deg,#eef2ff,#f8fafc);
        }

        .box {
            width:380px;
            margin:80px auto;
            background:white;
            padding:35px;
            border-radius:12px;
            box-shadow:0 15px 35px rgba(0,0,0,0.08);
        }

        h2 {
            text-align:center;
            margin-bottom:25px;
        }

        .input-group {
            margin-bottom:15px;
        }

        input {
            width:100%;
            padding:12px;
            border-radius:8px;
            border:1px solid #ddd;
            font-size:14px;
            transition:0.2s;
        }

        input:focus {
            border-color:#2563eb;
            outline:none;
            box-shadow:0 0 0 2px rgba(37,99,235,0.1);
        }

        .error {
            color:#dc2626;
            font-size:12px;
        }

        .valid {
            border:1px solid #16a34a;
        }

        .invalid {
            border:1px solid #dc2626;
        }

        .btn {
            background:#2563eb;
            color:white;
            border:none;
            padding:12px;
            width:100%;
            border-radius:8px;
            font-weight:600;
            transition:0.3s;
        }

        /* Disabled state */
        .btn:disabled {
            background:#9ca3af;   /* grey */
            cursor:not-allowed;
            opacity:0.7;
        }

        /* Optional: valid hover */
        .btn:not(:disabled):hover {
            background:#1e40af;
        }

        .strength {
            font-size:12px;
            margin-top:5px;
        }

    </style>

</head>

<body>

    <div class="box">

        <h2>Create Account</h2>

        <cfif structKeyExists(variables,"errorMsg")>
            <div class="error"><cfoutput>#errorMsg#</cfoutput></div>
        </cfif>

        <form method="post" onsubmit="return validateForm()">

            <div class="input-group">
                <input type="text" id="fname" name="first_name" placeholder="First Name">
                <small id="fnameErr" class="error"></small>
            </div>

            <div class="input-group">
                <input type="text" name="last_name" placeholder="Last Name">
            </div>

            <div class="input-group">
                <input type="text" id="phone" name="phone" placeholder="Phone">
                <small id="phoneErr" class="error"></small>
            </div>

            <div class="input-group">
                <input type="email" id="email" name="email" placeholder="Email">
                <small id="emailErr" class="error"></small>
            </div>

            <div class="input-group">
                <input type="password" id="password" name="password" placeholder="Password">
                <small id="passErr" class="error"></small>
                <div id="strength" class="strength"></div>
            </div>

            <input type="submit" id="submitBtn" name="submit" value="Register" class="btn" disabled>

        </form>

    </div>

    <script>
        const fname = document.getElementById("fname");
        const phone = document.getElementById("phone");
        const email = document.getElementById("email");
        const password = document.getElementById("password");
        const submitBtn = document.getElementById("submitBtn");
        const strengthEl = document.getElementById("strength");

        const fnameErr = document.getElementById("fnameErr");
        const phoneErr = document.getElementById("phoneErr");
        const emailErr = document.getElementById("emailErr");
        const passErr = document.getElementById("passErr");

        let emailExists = false;
        let debounceTimer;

        // COMMON FUNCTION → checks full form
        function checkFormValidity() {

            const isValid =
                fname.value.trim().length >= 2 &&
                /^[6-9][0-9]{9}$/.test(phone.value) &&
                /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value) &&
                password.value.length >= 6 &&
                !emailExists;

            submitBtn.disabled = !isValid;
        }

        // -------- First Name --------
        fname.addEventListener("input", () => {

            fnameErr.innerText = "";

            if (fname.value.trim().length < 2) {
                fnameErr.innerText = "Minimum 2 characters";
                fname.classList.add("invalid");
                fname.classList.remove("valid");
            } else {
                fname.classList.remove("invalid");
                fname.classList.add("valid");
            }

            checkFormValidity();
        });

        // -------- Phone --------
        phone.addEventListener("input", () => {

            phoneErr.innerText = "";

            if (!/^[6-9][0-9]{9}$/.test(phone.value)) {
                phoneErr.innerText = "Invalid phone number";
                phone.classList.add("invalid");
                phone.classList.remove("valid");
            } else {
                phone.classList.remove("invalid");
                phone.classList.add("valid");
            }

            checkFormValidity();
        });

        // -------- Email --------
        email.addEventListener("input", () => {

            emailErr.innerText = "";
            emailExists = false;

            const val = email.value;

            // basic format check
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val)) {
                emailErr.innerText = "Invalid email format";
                email.classList.add("invalid");
                email.classList.remove("valid");
                checkFormValidity();
                return;
            }

            // debounce API call
            clearTimeout(debounceTimer);

            debounceTimer = setTimeout(() => {

                fetch(`/EcommerceOSS/api/checkEmail.cfm?email=${encodeURIComponent(val)}`)
                    .then(res => res.json())
                    .then(data => {

                        if (data.exists) {
                            emailErr.innerText = "Email already registered";
                            email.classList.add("invalid");
                            email.classList.remove("valid");
                            emailExists = true;
                        } else {
                            email.classList.remove("invalid");
                            email.classList.add("valid");
                            emailExists = false;
                        }

                        checkFormValidity();
                    });

            }, 400); // wait while typing

        });

        // -------- Password --------
        password.addEventListener("input", () => {

            passErr.innerText = "";

            const val = password.value;

            if (val.length < 6) {
                passErr.innerText = "Minimum 6 characters";
                password.classList.add("invalid");
                password.classList.remove("valid");
            } else {
                password.classList.remove("invalid");
                password.classList.add("valid");
            }

            // strength
            if (val.length > 8 && /[A-Z]/.test(val) && /\d/.test(val)) {
                strengthEl.innerText = "Strong password";
                strengthEl.style.color = "green";
            } else if (val.length >= 6) {
                strengthEl.innerText = "Medium password";
                strengthEl.style.color = "orange";
            } else {
                strengthEl.innerText = "Weak password";
                strengthEl.style.color = "red";
            }

            checkFormValidity();
        });

        // -------- Final Submit --------
        function validateForm() {
            return !submitBtn.disabled;
        }
    </script>
</body>
</html>