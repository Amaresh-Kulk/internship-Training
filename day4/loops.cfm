<cfscript>
    a = 0; b = 1; c = 2; n = 10;
</cfscript>
<cfoutput>
    
    index loop:
    </br>#a#
    </br>#b#
    <cfloop from="1" to="#n - 2#" step="1" index="i">
        <cfscript>
            temp = b;
            b = a + b;
            a = temp;
        </cfscript>
        </br> #b#
    </cfloop>
    </hr>

    </br>while loop:</br>
    <!---  <cfbreak>,  <cfcontinue> --->
    <cfset count = 1>

    <cfloop condition="count LTE 5">
        <cfoutput>#count#<br></cfoutput>
        <cfset count = count + 1>
    </cfloop>
    </hr>

    </br> cfquery</br>
    <cfquery name="Qabcd" datasource="sqlserverDSN">
        SELECT id, a_name FROM abcd
    </cfquery>

    <cfoutput query="Qabcd">
        #id# - #a_name#<br>
    </cfoutput>

    <cfquery name="abcd1" datasource="practice1_1">
        select * from abcd
    </cfquery>

    <cfoutput query="abcd1">
        #id# - #name# </br>
    </cfoutput>
</cfoutput>


<cfloop from="1" to="10" index="i" step="2">

    <cfoutput>#i#</br></cfoutput>
</cfloop>

<cfset i = 1>
<cfloop condition="i lte 10">
    <cfoutput>
            #i#</br>
    </cfoutput>
    <cfset i = i + 1>
</cfloop>


<cfquery name="getName" datasource="sqlserverdsn">
    select a_name from abcd
</cfquery>

<cfloop query="getName">
    <cfoutput >
            #a_name#
        </cfoutput>
</cfloop>


<cfset list1= "ab1!ab2,ab3,ab4">
<cfloop list="#list1#" index="i" delimiters="!,">
    <cfoutput >
            #i#</br>
        </cfoutput>
</cfloop>

<cfset myBooks = StructNew()>

<cfset myVariable = StructInsert(myBooks,"ColdFusion","ColdFusion MX Bible")>

<cfset myVariable = StructInsert(myBooks,"HTML","HTML Visual QuickStart")>

<cfset myVariable = StructInsert(myBooks,"XML","Inside XML")>

<cfloop collection="#myBooks#" item="subject">

  <cfoutput>

 #subject#: #StructFind(myBooks,subject)#<br />

 </cfoutput>

</cfloop>


<cfset students = StructNew()>

<cfset myVariable = StructInsert(students, "abhi", 45)>
<cfset myVariable = StructInsert(students, "anuj", 70)>
<cfset myVariable = StructInsert(students, "bhushan", 90)>

<cfloop collection="#students#" item="i">
    <cfoutput>
            #i#: #structFind(students,i)#</br>
        </cfoutput>
</cfloop>



<cfloop from="1" to="10" index="i" step="2">
    <cfoutput >
            #i#</br>
        </cfoutput>
</cfloop>

<cfset j = 1>
<cfloop condition="j lte 10">
    <cfoutput >
            #j# <br/>
        </cfoutput>
        <cfset j = j + 1>
</cfloop>


<cfloop list="abcd pqrs xyzw trew" index="i" delimiters=" ">
    <cfoutput >
            #i#<br/>
        </cfoutput>
    
</cfloop>


<cfquery name="abcd2" datasource="practice1_1">
    select id, name from abcd;
</cfquery>

<cfloop query="abcd2">
    <cfoutput >
            #id#: #name#<br/>
        </cfoutput>
</cfloop>

<cfset sampleStruct = StructNew()>

<cfset myVariable = structInsert(sampleStruct,"hello1","nice to meet u")>
<cfset myVariable= structInsert(sampleStruct, "bye", "see you next time")>

<cfloop collection="#sampleStruct#" item="i">
    <cfoutput>
            #i#: #structFind(sampleStruct, i)#<br/>
        </cfoutput>
</cfloop>

<cfset myFile = "Harry" & chr(10) & "Garry" & chr(10) & "Henry">

<cfloop list="#myFile#" index="FileItem" delimiters="#chr(10)##chr(13)#">

  <cfoutput>

   #FileItem#<br />

 </cfoutput>

</cfloop>

<cfloop list="#myFile#" index="i" delimiters="#chr(10)#">
    <cfoutput >
            #i#<br/>
        </cfoutput>
</cfloop>

<cfinclude template="data.cfm" runonce="true">

<cfloop list="#fileData#" index="i" delimiters="#chr(10)#">
    <cfoutput>
        #i#<br/>
    </cfoutput>
</cfloop>



<cfoutput> <br/> <h1> Prime number </h1> <br/>

    <cfset isPrime = true>

    <cfset number = 1>

    <cfset i = 2>
    <cfif (number lte 1)>
        <cfset isPrime = false>
    <cfelse>
    <cfloop condition="i lte #int(sqr(number))#">
        <cfif (number mod i eq 0)>
            <cfset isPrime = false>
            <cfbreak>
        </cfif>
        <cfset i = i + 1>        
    </cfloop>
    </cfif>

    <cfif isPrime>
        <br/> It is prime
    <cfelse>
        <br/> It is not prime
    </cfif>
</cfoutput>
<cfparam name="var_sample" type="string" default="hello">
<cfif isDefined("var_sample")>
    <cfoutput>  variable is there:#var_sample# </cfoutput>
<cfelse>
    <cfoutput> variable not declared </cfoutput>
</cfif>



<cfscript>
list3 = "abcd, efgh, xyz";

</cfscript>

<cfoutput><br/>Length of list: #listLen(list3)# <br/></cfoutput>

<cfscript>
    list3 = listAppend(list3, "pqrs");
    list3 = listAppend(list3,"ghij");
    list3 = listInsertAt(list3, "3", "werd");

</cfscript>

<cfoutput >
    <br/> List: #list3#<br/>
    #listContains(list3,"ghij")#
    #listContainsNoCase(list3, "GHIj")#
</cfoutput>



<cfset person = {
    name = "Amaresh",
    age = 20
}>

<cfset person2 = structNew()>
<cfset person2.name = "Sachin">
<cfset person2.age = 22>

<cfoutput >
    <br/>
    Name: #person.name# <br/>
    Age: #person.age# <br/>
</cfoutput>

<cfdump var="#person#" >
<cfdump var="#person2#" >

<cfloop collection="#person#" item="key">
    <cfoutput >
            #key#: #structFind(person, key)# <br/>
        </cfoutput>
    
</cfloop>

<cfoutput >
    #structKeyExists(person2,"nam")#
    #structInsert(person,"email","amaresh@gmail.com")#
</cfoutput>


<cfloop collection="#person#" item="key">
    <cfoutput >
            #key# : #structFind(person, key)# hi<br/>
        </cfoutput>
</cfloop>

<cfscript>
    structDelete(person,"age");
</cfscript>

<cfloop collection="#person#" item="i">
    <cfoutput >
            #i#: #structFind(person, i)#<br/>
        </cfoutput>

</cfloop>


<h1>String Functions </h1>

<cfset name="    Amaresh     Kulkarni     Kulkarni">

<cfoutput>
    Length of the string: #len(name)# <br/>
    <cfset result = replace(name, "Kulkarni", "Shirish Kulkarni", "all")>
    Result: #result# <br/>
    UpperCase: #ucase(name)#<br/>
    Lowercase: #lcase(name)#<br/>
    trim: #trim(name)#<br/>
    Ltrim: #lTrim(name)#<br/>
    Rtrim: #rTrim(name)#<br/>
    Find: #find("Amaresh",name)#<br/>
    findNoCase: #findNoCase("KulkarnI",name)# <br/>
    left: #left(name, 5)# <br/>
    right: #right(name, 8)# <br/>
    mid: #mid(name, 8, 3)# <br/>
    & : #"h " & "Amaresh"# <br/>
    <cfset str2 = "" && "Amaresh">
     &&: #"" && "Amaresh"# <br/>
     &&: #str2#<br/>
</cfoutput>


<h1> List functions </h1>

