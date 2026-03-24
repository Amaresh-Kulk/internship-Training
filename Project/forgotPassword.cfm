<!-- DEFAULT STEP -->
<cfparam name="currentStep" default="1">

<!-- STEP 1: SEND OTP -->
<cfif structKeyExists(form,"sendOTP")>

    <cfquery name="checkUser" datasource="securitydb">
        SELECT id,email
        FROM Users
        WHERE email =
        <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif checkUser.recordCount EQ 1>

        <cfset otp = randRange(100000,999999)>

        <cfset session.resetOTP = otp>
        <cfset session.resetUserID = checkUser.id>
        <cfset session.resetEmail = checkUser.email>
        <cfset session.otpTime = now()>

        <cfmail
            to="#checkUser.email#"
            from="noreply@store.com"
            subject="Password Reset OTP"
            server="smtp.yopmail.com"
            port="25"
            type="html">

            <h3>Password Reset Request</h3>
            Your OTP is:
            <h2>#otp#</h2>
            Valid for 5 minutes.

        </cfmail>

        <cfset currentStep = 2>

    <cfelse>
        <cfset errorMsg="Email not found">
    </cfif>

</cfif>

<!-- STEP 2: VERIFY OTP -->
<cfif structKeyExists(form,"verifyOTP")>

    <cfif dateDiff("n", session.otpTime, now()) GT 5>
        <cfset errorMsg="OTP expired. Please request again.">
        <cfset currentStep = 1>

    <cfelseif form.otp EQ session.resetOTP>
        <cfset currentStep = 3>

    <cfelse>
        <cfset errorMsg="Invalid OTP">
        <cfset currentStep = 2>
    </cfif>

</cfif>

<!-- STEP 3: RESET PASSWORD -->
<cfif structKeyExists(form,"resetPassword")>

    <cfif form.password NEQ form.confirmPassword>

        <cfset errorMsg="Passwords do not match">
        <cfset currentStep = 3>

    <cfelse>

        <cfset hashedPassword = hash(form.password,"SHA-256")>

        <cfquery datasource="securitydb">
            UPDATE Users
            SET password =
                <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
            WHERE id =
                <cfqueryparam value="#session.resetUserID#" cfsqltype="cf_sql_integer">
        </cfquery>

        <cfset structClear(session)>

        <cflocation url="login.cfm?reset=success" addtoken="false">

    </cfif>

</cfif>


<!DOCTYPE html>
<html>
<head>

    <title>Forgot Password</title>

    <style>
        body {
            font-family:Segoe UI;
            background:#f4f6f9;
        }

        .box {
            width:380px;
            margin:100px auto;
            background:white;
            padding:35px;
            border-radius:10px;
            box-shadow:0 10px 25px rgba(0,0,0,0.08);
        }

        input {
            width:100%;
            padding:10px;
            margin:8px 0;
            border-radius:6px;
            border:1px solid #ddd;
        }

        .btn {
            background:#2563eb;
            color:white;
            border:none;
            padding:12px;
            width:100%;
            border-radius:6px;
            font-weight:600;
        }

        .error {
            color:red;
            text-align:center;
        }
    </style>

</head>

<body>

    <div class="box">

        <h2>Forgot Password</h2>

        <cfif structKeyExists(variables,"errorMsg")>
            <div class="error">
                <cfoutput>#errorMsg#</cfoutput>
            </div>
        </cfif>

        <!-- STEP 1 -->
        <div id="step1">
            <form method="post">
                <input type="email" name="email" placeholder="Enter your email" required>
                <button name="sendOTP" class="btn">Send OTP</button>
            </form>
        </div>

        <!-- STEP 2 -->
        <div id="step2" style="display:none;">
            <form method="post">
                <input type="text" name="otp" placeholder="Enter OTP" required>
                <button name="verifyOTP" class="btn">Verify OTP</button>
            </form>
        </div>

        <!-- STEP 3 -->
        <div id="step3" style="display:none;">
            <form method="post">
                <input type="password" name="password" placeholder="New Password" required>
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                <button name="resetPassword" class="btn">Reset Password</button>
            </form>
        </div>

    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {

            const step = <cfoutput>#currentStep#</cfoutput>;

            document.getElementById("step1").style.display = "none";
            document.getElementById("step2").style.display = "none";
            document.getElementById("step3").style.display = "none";

            if (step === 1) document.getElementById("step1").style.display = "block";
            if (step === 2) document.getElementById("step2").style.display = "block";
            if (step === 3) document.getElementById("step3").style.display = "block";

        });
    </script>
</body>
</html>
