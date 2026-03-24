<cfcomponent displayname="File">

    
    <cffunction name="uploadFile" access="public" returntype="struct">
        <cfargument name="fileField" required="true">

        <cfset var result = structNew()>

        <cftry>

            <cffile action="upload"
                    filefield="#arguments.fileField#"
                    destination="../uploads/"
                    nameconflict="makeunique"
                    accept="image/*">

            <cfset result.status = "success">
            <cfset result.message = "File uploaded successfully.">
            <cfset result.fileName = cffile.serverFile>

        <cfcatch>

           
            <cflog file="error"
                    text="#now()# , Upload Error , #cfcatch.message#">

            <cfset result.status = "error">
            <cfset result.message = cfcatch.message>

        </cfcatch>
        </cftry>

        <cfreturn result>
    </cffunction>



    
    <cffunction name="writeFile" access="public" returntype="string" >

        <cfset var filePath = expandPath("../files/") & "sample.txt">

        <cftry>

            <cffile action="write"
                    file="#filePath#"
                    output="This is a sample file created at #now()#">

            <cfreturn "File written successfully.">

        <cfcatch>

            <cflog file="error"
                    text="#now()# , Write Error , #cfcatch.message#">

            <cfreturn "Error while writing file.">

        </cfcatch>
        </cftry>

    </cffunction>



    
    <cffunction name="readFile" access="public" returntype="string">

        <cfset var filePath = expandPath("../files/") & "sample.txt">

        <cftry>

            <cffile action="read"
                    file="#filePath#"
                    variable="fileContent">

            <cfreturn fileContent>

        <cfcatch>

            <cflog
                    file="error"
                    text="#now()# , Read Error , #cfcatch.message#">

            <cfreturn "Error while reading file.">

        </cfcatch>
        </cftry>

    </cffunction>



    
    <cffunction name="moveFile" access="public" returntype="string">

        <cfset var sourcePath = expandPath("../files/") & "sample.txt">
        <cfset var destinationPath = expandPath("../files/") & "moved_sample.txt">

        <cftry>

            <cffile action="move"
                    source="#sourcePath#"
                    destination="#destinationPath#">

            <cfreturn "File moved successfully.">

        <cfcatch>

            <cflog file="error"
                    text="#now()# , Move Error , #cfcatch.message#">

            <cfreturn "Error while moving file.">

        </cfcatch>
        </cftry>

    </cffunction>

</cfcomponent>