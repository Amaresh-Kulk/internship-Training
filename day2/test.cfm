<html>
<head>
    <title>My First CF Page</title>
</head>
<body>

<cfinclude template= "test2.cfm">

<cfset message = "Hello ColdFusion">
<cfset var1 = 1>
<cfset var2 =  var1 + 3.1>
<cfset string2 = 'single Quote'>

<!---cfparam --->
<cfparam name = "var3" default= 2 type= "numeric">

<!---boolean--->
<cfset isTrue = true>

<!--- array --->
<cfset arr = ["red", "blue", "orange"]> 
<!--- or --->
<cfset arr2 = ArrayNew(1)>
<cfset arr2[1] = "black">
<cfset arr2[2] = "green">


<!--- structure --->
<cfset person = {
    name = "John",
    age = 30,
    city = "London"
}>
<!--- or --->

<cfset person2 = StructNew()>
<cfset person2.name = "Mike">
<cfset person2.age = 30>

<cfset users = [
    {name="Alice", age=25},
    {name="Bob", age=30}
]>

<cfset text2= "      John    ">


<cfset text= "I like cats and cats">

<!--- <cfoutput> --->
<cfoutput> 
    <h2>
        Variables
    </h2>

    <h1>#message#</h1>
    <p> #var1#</p>
    <p> #var2#</p>

    <h2>
        If else statement
    </h2>
    <cfif var1 gte 1>
        more than 1
    <cfelse>
        less than 1
    </cfif>

    </br>

    <h2>    Functions </h2>

    <h2>#getGreeting(userName)#</h2>

    <h2> #var3# </h2>
    <h2> String Operations </h2>
    <h3> #ucase(string2)#</h3>
    
    <h5> #replace(text, "cats", "dogs", "all")# 
        </br>length of string: #len(text)#
    </h5> 
    <h4> #text2# </h4>
    <h2> Numeric Operations </h2>

    <p> Round of 5.2: round(5.2) </p>

    <cfif isNumeric(var1)>Number!</cfif>
  

    <p>
        Max is : #max(22, 22.1)#
    </p>

    <h2> Boolean </h2>
    <cfif isTrue>
        <p> It is true </p>
    <cfelse>
        <p> It is false</p>
    </cfif>

    <h3> looping through array </h3>
    <!--- looping --->
    <cfloop array = "#arr#" index= "c">
        #c# </br>
    </cfloop>

    <cfset arrayAppend(arr, "purple")>
    <cfset arrayDeleteAt(arr, 1)>

     <h3> looping through array after insertion and deleteion</h3>
    <!--- looping --->
    <cfloop array = "#arr#" index= "c">
        #c# </br>
    </cfloop>

    <h2> Structure </h2>
    <p>Person name: #person.name# </br> </p>


    <!---looping through structure --->

    <cfloop collection="#person#" item="key">
        <cfoutput>#key#: #person[key]#<br></cfoutput>
    </cfloop>

    <p>#users[2].name#</p>   <!--- Bob --->

    <cfif isArray(arr)>Array!</cfif>
    <cfif isStruct(person)>Struct!</cfif>


   
</cfoutput>

</body>
</html>