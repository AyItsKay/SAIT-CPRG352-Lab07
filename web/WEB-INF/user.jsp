<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
        <title>User Manager (Green Tea)</title>
    </head>
    <body class="bg-success bg-opacity-75">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
        <div class="row p-5">
            <div class="col-3">
                <div class="card text-bg-dark">
                    <c:choose>
                        <c:when test="${defaultTitle == true}">
                            <h1 class="card-header">Welcome</h1>
                        </c:when>
                        <c:when test="${addUser == true}">
                            <h1 class="card-header">Add User</h1>
                        </c:when>
                        <c:when test="${editUser == true}">
                            <h1 class="card-header">Edit User</h1>
                        </c:when>
                    </c:choose>
                    <div class="card-body">
                        <form method="post" action="User">
                            <img src="./06e20fac9ae6bd96981f8da9ee81d48f.gif.ddd3512b91d59deab4e6200022a14b0f.gif" class="rounded mx-auto w-100 d-block m-0"><br>
                            <c:choose>
                                <c:when test="${enableForm == true}">
                                    <input type="submit" value="Add User"  class="btn btn-primary" disabled>          
                                    <br><br>
                                    <c:choose>
                                        <c:when test="${addUser == true}">                       
                                            <input type="email" name="email" placeholder="Email" class="form-control text-bg-dark">
                                        </c:when>
                                        <c:when test="${editUser == true}">
                                            <input type="email" name="email" placeholder="Email" class="form-control text-bg-dark" value=${userToEdit.email} readonly>
                                        </c:when>        
                                    </c:choose>
                                    <div class="form-check form-check-inline text-success">                               
                                        <div class="badge-success p-2 m-0">
                                            <input class="form-check-input" type="radio" name="isActive" id="activeRadio" onclick = \"getAnswer('active') value='active' ${userToEdit.email == null || userToEdit.active ? 'checked': ''}>
                                            <label class="form-check-label" for="activeRadio">Active</label>
                                        </div>
                                    </div>
                                    <div class="form-check form-check-inline text-danger">
                                        <div class="badge-danger p-2 m-0">
                                            <input class="form-check-input" type="radio" name="isActive" id="inactiveRadio" onclick = \"getAnswer('active') value="inactive" ${userToEdit.email != null && !userToEdit.active ? 'checked':''}>
                                            <label class="form-check-label" for="inactiveRadio">Inactive</label>
                                        </div>
                                    </div>
                                    <input type="text" name="firstName" placeholder="First Name" class="form-control text-bg-dark" value=${userToEdit.firstName}>
                                    <br>
                                    <input type="text" name="lastName" placeholder="Last Name" class="form-control text-bg-dark" value=${userToEdit.lastName}>
                                    <br>
                                    <input type="password" name="password" placeholder="Password" class="form-control text-bg-dark" value=${userToEdit.password} >
                                    <br>                                    
                                    <select name="roleName" class="form-control text-bg-dark">
                                        <c:forEach items="${roles}" var="role">
                                            <option value=${role.roleID} ${role.roleID == userToEdit.role ? 'selected="selected"' : ''}>${role.roleName}</option> 
                                        </c:forEach>                        
                                    </select>   
                                    <br>
                                    <input type="submit" value="Save" class="btn btn-success">
                                    <input type="hidden" name="action" value="saveUser">    
                                </c:when>
                                <c:when test="${enableForm == false}">
                                    <input type="submit" value="Add User" class="btn btn-primary">
                                    <br><br>
                                    <input type="hidden" name="action" value="addUser">                   
                                    <input type="email" name="email" class="form-control bg-dark" value="Email" disabled>
                                    <div class="form-check form-check-inline">
                                        <div class="badge-secondary p-2 m-0">
                                            <input class="form-check-input" type="radio" name="isActive" id="activeRadio" value="active" disabled>
                                            <label class="form-check-label" for="activeRadio" style="color: white">Active</label>
                                        </div>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <div class="badge-secondary p-2 m-0">
                                            <input class="form-check-input" type="radio" name="isActive" id="inactiveRadio" value="inactive" disabled>
                                            <label class="form-check-label" for="inactiveRadio" style="color: white">Inactive</label>
                                        </div>
                                    </div>
                                    <input type="text" name="firstName" class="form-control bg-dark" value="First Name" disabled>
                                    <br>
                                    <input type="text" name="lastName" class="form-control bg-dark" value="Last Name" disabled>
                                    <br>
                                    <input type="text" name="password" class="form-control bg-dark" value="Password" disabled>
                                    <br>
                                    <select name="roleName" class="form-control bg-dark" disabled>
                                        <option>Role</option>
                                    </select>  
                                    <br>
                                    <input type="submit" value="Save" class="btn btn-success" disabled>     
                                </c:when>            
                            </c:choose>      
                        </form>
                        <br>
                        <form method="post" action="User">
                            <c:choose>
                                <c:when test="${cancelForm == true}">
                                    <input type="submit" value="Cancel" class="btn btn-secondary">
                                    <input type="hidden" name="action" value="cancel">                                         
                                </c:when>
                                <c:when test="${cancelForm == false}">
                                    <input type="submit" value="Cancel" class="btn btn-secondary" disabled>            
                                </c:when>            
                            </c:choose>
                        </form>
                    </div>
                </div>
            </div>
            
            <div class="col-9">
                <div class="card text-bg-dark">
                    <h1 class="card-header">Manage Users</h1>
                    <div class="card-body">
                        <table class="table">
                            <thead class="text-bg-dark">
                                <tr>
                                    <th>Email Address</td>
                                    <th>Active</th>
                                    <th>First Name</td>
                                    <th>Last Name</td>
                                    <th>Role</td>
                                    <th>Edit</td>
                                    <th>Delete</td>
                                </tr>
                            </thead>
                            <c:forEach items="${users}" var="user">
                                <tr class="text-white">
                                    <td>${user.email}</td>
                                    <td>
                                        ${user.active ? '<span class="badge text-bg-success">Active</span>' : '<span class="badge text-bg-danger">Inactive</span>'}
                                    </td>
                                    <td>${user.firstName}</td>
                                    <td>${user.lastName}</td>
                                    <c:forEach items="${roles}" var="role">
                                        <c:if test="${role.roleID == user.role}">
                                            <td>${role.roleName}</td>
                                        </c:if>
                                    </c:forEach>
                                    <td>
                                        <form action="User" method="post">
                                            <input type="submit" value="Edit" class="btn btn-success">
                                            <input type="hidden" name="action" value="editUser">
                                            <input type="hidden" name="key" value=${user.email}>
                                        </form>         
                                    </td>
                                    <td>
                                        <form action="User" method="post">
                                            <input type="submit" value="Delete"class="btn btn-secondary">
                                            <input type="hidden" name="action" value="deleteUser">
                                            <input type="hidden" name="key" value=${user.email}>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>  
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>