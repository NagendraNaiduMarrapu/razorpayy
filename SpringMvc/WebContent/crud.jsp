<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	id:<input type="text" name="id" id="id"/><br><br>
	Name:<input type="text" name="name" id="name"/><br><br>
	Department:<input type="text" name="dept" id="dept"/><br><br>
	Salary : <input type="text" name="sal" id="sal"/><br><br>
	Mode:<select id="selectt">
	<option>Edit</option>
	<option>Add</option>
	<option>Delete</option>
	</select> <br><br>
	<button name="first" onclick="first()">First</button>
	<button name="next" onclick="next()">Next</button>
	<button name="previous" onclick="prev()">previous</button>
	<button name="last" onclick="last()">last</button><br><br>
	<button name="edit" id="edit" onclick="edit()">edit</button>
	<button name="save" onclick="save()">save</button>
	<button name="add" onclick="add()">add</button>
	<button name="delete" onclick="deletee()">Delete</button><br><br>
	<button name="exit">Exit</button>
	<button name="clear">Clear</button>
	<button name="search">Search</button>
</body>

<script>
function first() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", `http://localhost:8080/SpringMvc/first`, true);

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                console.log(xhr.responseText);
                var userData = JSON.parse(xhr.responseText);
                document.getElementById("id").value = userData.id;
                document.getElementById("name").value = userData.name;
                document.getElementById("dept").value = userData.department;
                document.getElementById("sal").value = userData.salary;
            } else {
                console.error('Request failed:', xhr.statusText);
            }
        }
    };

    xhr.send();
}


function last() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", `http://localhost:8080/SpringMvc/last`, true);

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                console.log(xhr.responseText);
                var userData = JSON.parse(xhr.responseText);
                document.getElementById("id").value = userData.id;
                document.getElementById("name").value = userData.name;
                document.getElementById("dept").value = userData.department;
                document.getElementById("sal").value = userData.salary;
            } else {
                console.error('Request failed:', xhr.statusText);
            }
        }
    };

    xhr.send();
}



</script>

</html>