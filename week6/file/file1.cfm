<!---<form action="" method="post" enctype="multipart/form-data">
    <input type="file" name="myFile">
    <input type="submit" value="Upload">
</form>

<cftry>
    <cfif structKeyExists(form, "myFile")>
        <cffile 
            action="upload"
            filefield="myFile"
            destination="C:/Users/amaresh.k/Documents/Week6/"
            nameconflict="overwrite">

    </cfif>
<cfcatch >
    <cfoutput >
            #cfcatch.type#, #cfcatch.message#<br/>
        </cfoutput>
</cfcatch>

</cftry>

<cffile action="read" file="#expandPath("../trycatch/sampletext.txt")#" variable="text" >

<cfoutput >
    #text#<br/>
</cfoutput>

<cffile action="read" file="#expandPath("../trycatch/cfmail.cfm")#" variable="mail">

<cfoutput >
    #mail#<br/>
</cfoutput>


<cffile 
    action="read"
    file="#expandPath('../trycatch/image.jpg')#"
    variable="image1">


<cfcontent 
    file="#expandPath('../trycatch/image.jpg')#"
    type="image/jpeg"
    >


<cfscript>
    binary = fileReadBinary(expandPath("../trycatch/image.jpg"));
    cfcontent(
        type = "image/jpeg",
        variable = binary
    );
</cfscript>


<form action="" method="post">
    <input type="text" name="value">
    <input type="submit">
</form>

<cfif structKeyExists(form, "value")>
    <cffile action="write" output="#form.value#" file="#expandPath("here.txt")#">

    <cffile action="read" file="#expandPath("here.txt")#" variable="sample">
    <cfoutput >
            #sample#<br/>
        </cfoutput>
</cfif>


<form action="" method="post">
    <input type="text" name="value">
    <input type="submit">
</form>

<cfif structKeyExists(form,"value")>
    <cffile action="append" output="#form.value#" file="#expandPath("here2.txt")#">

    <cffile action="read" file="#expandPath("here2.txt")#" variable="sa">

    <cfoutput >
        #sa#<br/>
    </cfoutput>
</cfif>



<form action="" method="post">
    Source: <input type="text" name="source">
    Destination: <input type="text" name="destination">
    <input type="submit">
</form>

<cfif structKeyExists(form, "destination")>
    <cfif not fileExists(expandPath(form.source) & ".txt")>
        <cffile action="append" file="#expandPath(form.source & ".txt")#" output="1">        
    </cfif>
    <cffile action="rename" source="#expandPath(form.source & ".txt")#" 
        destination="#expandPath(form.destination & ".txt")#">
</cfif>


<form action="" method="post">
    Source: <input type="text" name="source">
    Destination: <input type="text" name="destination">
    <input type="submit">
</form>

<cfif structKeyExists(form, "destination")>
    <cfif not fileExists(expandPath(form.source) & ".txt")>
        <cffile action="append" file="#expandPath(form.source & ".txt")#" output="1">        
    </cfif>
    <cffile action="copy" source="#expandPath(form.source & ".txt")#" 
        destination="#expandPath(form.destination & ".txt")#">
</cfif>




<form action="" method="post">
    Source: <input type="text" name="source">
    Destination: <input type="text" name="destination">
    <input type="submit">
</form>

<cfif structKeyExists(form, "destination")>
    <cfif not fileExists(expandPath(form.source) & ".txt")>
        <cffile action="append" file="#expandPath(form.source & ".txt")#" output="1">        
    </cfif>
    <cffile action="move" source="#expandPath(form.source & ".txt")#" 
        destination="#expandPath(form.destination & ".txt")#">
</cfif>



<form action="" method="post" enctype="multipart/form-data">
    File 1:<input type="file" name="file1"><br/>
    File 2:<input type="file" name="file2">
    
    Path:<input type="text" name="path">
    <input type="submit">
</form>

<cfif structKeyExists(form,"path")>
    <cftry>
        <cffile action="uploadall" destination="#expandPath(form.path)#" nameconflict="makeunique"
            >
        <cfoutput >
                   Files uploaded successfully<br/> 
                </cfoutput>
    <cfcatch >
        <cfoutput >
                   Error uploading files<br/> 
                </cfoutput>        
    </cfcatch>
    <cfdump var="#cffile#" >
    </cftry>
    
</cfif>


<cfscript>
    binary = fileReadBinary(expandPath("../trycatch/image.jpg"));
    cfcontent(
        type = "image/jpeg",
        variable = binary
    );
</cfscript>
--->
<div>
    <cfcontent 
        file="#expandPath('../trycatch/image.jpg')#"
        type="image/jpeg"
        >
</div>

<style>
    div {
        height: 500px;
        width: 500px;
    }
</style>