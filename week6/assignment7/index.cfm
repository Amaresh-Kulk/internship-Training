<!DOCTYPE html>
<html>
<head>
    <title>Assignment 7 - File & Email Operations</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 500px;
            margin: 80px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 10px;
            color: #333;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            margin: 20px 0;
        }

        a {
            text-decoration: none;
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            display: inline-block;
            transition: 0.3s;
        }

        a:hover {
            background-color: #0056b3;
        }

    </style>
</head>

<body>

    <div class="container">

        <h2>Assignment 7</h2>
        <p>File Handling & Email Configuration</p>
        <hr>

        <ul>
            <li>
                <a href="views/uploadForm.cfm">
                    Upload Image File
                </a>
            </li>

            <li>
                <a href="views/fileOperations.cfm">
                    File Read / Write / Move
                </a>
            </li>

            <li>
                <a href="views/emailForm.cfm">
                    Send Email (Fake SMTP)
                </a>
            </li>
        </ul>



    </div>

</body>
</html>