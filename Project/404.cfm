<!DOCTYPE html>
<html>
<head>
<title>404 - Page Not Found</title>

<style>

    body{
    font-family:'Segoe UI',sans-serif;
    background:#f4f6f9;
    margin:0;
    display:flex;
    align-items:center;
    justify-content:center;
    height:100vh;
    }

    .container{
    text-align:center;
    }

    .error-code{
    font-size:120px;
    font-weight:700;
    color:#2563eb;
    margin-bottom:10px;
    }

    .message{
    font-size:22px;
    color:#374151;
    margin-bottom:10px;
    }

    .sub{
    color:#6b7280;
    margin-bottom:30px;
    }

    .btn{
    display:inline-block;
    background:#2563eb;
    color:white;
    padding:12px 24px;
    border-radius:8px;
    text-decoration:none;
    font-weight:600;
    }

    .btn:hover{
    background:#1e40af;
    }

</style>

</head>

<body>

    <div class="container">

        <div class="error-code">
            404
        </div>

        <div class="message">
            Page Not Found
        </div>

        <div class="sub">
            The page you are looking for does not exist.
        </div>

        <a href="/EcommerceOSS/login.cfm" class="btn">
            Go to Login
        </a>

    </div>

</body>
</html>