<cfparam name="form.currentFolder" default="files">


<cfif NOT listFindNoCase("files,moved", form.currentFolder)>
    <cfset form.currentFolder = "files">
</cfif>

<cfset basePath = expandPath("../")>
<cfset currentPath = basePath & form.currentFolder & "/">


<cfif form.currentFolder EQ "files">
    <cfset targetFolder = "moved">
<cfelse>
    <cfset targetFolder = "files">
</cfif>


<cfif structKeyExists(form, "action")>

    
    <cfif form.action EQ "create" 
          AND structKeyExists(form,"newFileName") 
          AND len(trim(form.newFileName))>

        <cfset filePath = currentPath & trim(form.newFileName) & ".txt">

        <cftry>
            <cffile action="write"
                    file="#filePath#"
                    output="File created at #now()#">

            <cfset message = "File created successfully.">

        <cfcatch>
            <cfset message = "Error creating file: " & cfcatch.message>
        </cfcatch>
        </cftry>


    
    <cfelseif form.action EQ "delete" 
            AND structKeyExists(form,"filename")>

        <cfset filePath = currentPath & trim(form.filename)>

        <cftry>
            <cffile action="delete"
                    file="#filePath#">

            <cfset message = "File deleted successfully.">

        <cfcatch>
            <cfset message = "Error deleting file: " & cfcatch.message>
        </cfcatch>
        </cftry>


    
    <cfelseif form.action EQ "read" 
            AND structKeyExists(form,"filename")>

        <cfset filePath = currentPath & trim(form.filename)>

        <cftry>
            <cffile action="read"
                    file="#filePath#"
                    variable="fileContent">

            <cfset editingFile = form.filename>

        <cfcatch>
            <cfset message = "Error reading file: " & cfcatch.message>
        </cfcatch>
        </cftry>


    
    <cfelseif form.action EQ "update" 
            AND structKeyExists(form,"filename")>

        <cfset filePath = currentPath & trim(form.filename)>

        <cftry>
            <cffile action="write"
                    file="#filePath#"
                    output="#form.updatedContent#">

            <cfset message = "File updated successfully.">

        <cfcatch>
            <cfset message = "Error updating file: " & cfcatch.message>
        </cfcatch>
        </cftry>


    
    <cfelseif form.action EQ "move" 
            AND structKeyExists(form,"filename")>

        <cfset sourcePath = currentPath & trim(form.filename)>
        <cfset destinationPath = basePath & targetFolder & "/" & trim(form.filename)>

        <cftry>
            <cffile action="move"
                    source="#sourcePath#"
                    destination="#destinationPath#">

            <cfset message = "File moved successfully.">

        <cfcatch>
            <cfset message = "Error moving file: " & cfcatch.message>
        </cfcatch>
        </cftry>

    </cfif>
</cfif>

<!DOCTYPE html>
<html>
    <head>
        <title>File Operations</title>
        <style>
            body { 
                font-family: Arial; 
                background:#f4f6f9; 
            }
            .container {
                width: 900px;
                margin: 50px auto;
                background: white;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            button {
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: white;
            }
            .readBtn { 
                background-color: #28a745; 
            }
            .moveBtn { 
                background-color: #dc3545; 
            }
            .createBtn { 
                background-color: #007bff; 
            }
            .load { 
                background-color: #c85f5f; 
            }
            .result {
                margin-top: 20px;
                padding: 10px;
                background: #f1f1f1;
                border-radius: 5px;
            }
            a   {
                float: right;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>File Operations</h2>

            
            <form method="post">
                <cfoutput>
                    Select Folder:
                    <select name="currentFolder">
                        <option value="files" <cfif form.currentFolder EQ "files">selected</cfif>>Files</option>
                        <option value="moved" <cfif form.currentFolder EQ "moved">selected</cfif>>Moved</option>
                    </select>
                </cfoutput>
                <button type="submit" class="load">Load</button>
            </form>

            
            <form method="post">
                <cfoutput>
                    <input type="hidden" name="currentFolder" value="#form.currentFolder#">
                </cfoutput>
                File Name:
                <input type="text" name="newFileName" required>
                <button class="createBtn" name="action" value="create">
                    Create File
                </button>
            </form>

            
            <cfset fileList = directoryList(currentPath, false, "query", "*.txt")>

            <table>
                <tr>
                    <th>File Name</th>
                    <th>Read</th>
                    <th>Move to <cfoutput>#targetFolder#</cfoutput></th>
                    <th>Delete</th>
                </tr>

                <cfoutput query="fileList">
                <tr>
                    <td>#name#</td>

                    <td>
                        <form method="post">
                            <input type="hidden" name="currentFolder" value="#form.currentFolder#">
                            <input type="hidden" name="filename" value="#name#">
                            <button class="readBtn" name="action" value="read">Read</button>
                        </form>
                    </td>

                    <td>
                        <form method="post">
                            <input type="hidden" name="currentFolder" value="#form.currentFolder#">
                            <input type="hidden" name="filename" value="#name#">
                            <button class="moveBtn" name="action" value="move">Move</button>
                        </form>
                    </td>

                    <td>
                        <form method="post">
                            <input type="hidden" name="currentFolder" value="#form.currentFolder#">
                            <input type="hidden" name="filename" value="#name#">
                            <button class="moveBtn" name="action" value="delete"
                                onclick="return confirm('Are you sure?')">
                                Delete
                            </button>
                        </form>
                    </td>

                </tr>
                </cfoutput>
            </table>

            
            <cfif structKeyExists(variables, "editingFile")>
                <h3>Edit File: <cfoutput>#editingFile#</cfoutput></h3>

                <form method="post">
                    <cfoutput>
                        <input type="hidden" name="currentFolder" value="#form.currentFolder#">
                        <input type="hidden" name="filename" value="#editingFile#">
                    </cfoutput>

                    <cfoutput>
                        <textarea name="updatedContent" rows="10" style="width:100%;">#fileContent#</textarea>
                    </cfoutput>
                    <br><br>
                    <button name="action" value="update" class="createBtn">
                        Save Changes
                    </button>
                </form>
            </cfif>

            
            <cfif structKeyExists(variables,"message")>
                <div class="result">
                    <cfoutput>#message#</cfoutput>
                </div>
            </cfif>
            <a href="../index.cfm">Back to Home</a>
        </div>
    </body>
</html>