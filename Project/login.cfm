<!DOCTYPE html>
<html>
<head>
<title>Login</title>

<style>

    body{
    font-family:Segoe UI;
    background:#f4f6f9;
    margin:0;
    }

    .box{
    width:380px;
    margin:100px auto;
    background:white;
    padding:35px;
    border-radius:10px;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
    }

    h2{
    text-align:center;
    margin-bottom:25px;
    }

    input{
    width:100%;
    padding:10px;
    margin:8px 0;
    border-radius:6px;
    border:1px solid #ddd;
    }

    .btn{
    background:#2563eb;
    color:white;
    border:none;
    padding:12px;
    cursor:pointer;
    width:100%;
    border-radius:6px;
    font-weight:600;
    margin-top:10px;
    }

    .btn:hover{
    background:#1e40af;
    }

    .error{
    color:red;
    text-align:center;
    margin-bottom:10px;
    }

    .links{
    text-align:center;
    margin-top:15px;
    font-size:14px;
    }

    .links a{
    color:#2563eb;
    text-decoration:none;
    font-weight:600;
    margin:0 8px;
    }

    .links a:hover{
    text-decoration:underline;
    }

</style>
</head>

<body>

    <div class="box">

        <h2>Login</h2>

        <cfif structKeyExists(form,"submit")>

            <cfset hashedPassword = hash(form.password,"SHA-256")>

            
            <cfquery name="checkUser" datasource="securitydb">
                SELECT u.id,u.name,r.role
                FROM Users u
                INNER JOIN Roles r ON u.roleID = r.id
                WHERE u.email =
                <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
                AND u.password =
                <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
            </cfquery>

            <cfif checkUser.recordCount EQ 1>

                <cfset session.userID = checkUser.id>
                <cfset session.userName = checkUser.name>
                <cfset session.role = checkUser.role>
                <cfset session.isLoggedIn = true>

                <cfif session.role EQ "admin">
                    <cflocation url="admin/dashboard.cfm" addtoken="false">
                <cfelse>
                    <cflocation url="customer/dashboard.cfm" addtoken="false">
                </cfif>

            <cfelse>

                <div class="error">
                    Invalid Email or Password
                </div>

            </cfif>

        </cfif>


        <form method="post">

            <input type="email" name="email" placeholder="Email" required>

            <input type="password" name="password" placeholder="Password" required>

            <input type="submit" name="submit" value="Login" class="btn">

        </form>


        <div class="links">

            <a href="forgotPassword.cfm">Forgot Password?</a>

            |

            <a href="register.cfm">Create Account</a>

        </div>

    </div>

</body>
</html>