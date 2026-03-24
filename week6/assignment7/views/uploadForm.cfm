<!DOCTYPE html>
<html>
<head>
    <title>Upload Image</title>

    <style>
        body { font-family: Arial; background-color: #f4f6f9; }
        .container {
            width: 500px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        input[type="file"] { margin: 15px 0; }
        button {
            padding: 10px 20px;
            border: none;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover { background-color: #1e7e34; }
        .result {
            margin-top: 20px;
            padding: 10px;
            background-color: #f1f1f1;
            border-radius: 5px;
        }
        img {
            margin-top: 15px;
            max-width: 100%;
            border-radius: 5px;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Upload Image File</h2>

    <form action="" method="post" enctype="multipart/form-data">
        <input type="file" name="myImage" required>
        <br>
        <button type="submit" name="uploadBtn">Upload</button>
    </form>

    <div class="result">

        <cfif structKeyExists(form, "uploadBtn")>

            <cfset fileObj = createObject("component","File")>
            <cfset result = fileObj.uploadFile("myImage")>

            <cfoutput>
                #result.message#

                <cfif result.status EQ "success">
                    <br><br>
                    Uploaded File: #result.fileName#
                    <br>
                    <img src="../uploads/<cfoutput >#result.fileName#</cfoutput>" alt="Uploaded Image">
                </cfif>

                <cfif result.status EQ "error">
                    <br><br>
                    Only JPG, PNG, GIF images are allowed.
                </cfif>

            </cfoutput>

        </cfif>

    </div>

    <a href="../index.cfm">Back to Home</a>

</div>

</body>
</html>