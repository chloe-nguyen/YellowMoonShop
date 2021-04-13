
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" 
              integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" 
              crossorigin="anonymous">
        <title>Create Product Page</title>
        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>
        <script>
            function validatedForm() {
                var mfg = document.getElementById("inputMfg").value;
                var exp = document.getElementById("inputExp").value;

                if ((new Date(mfg).getTime() < new Date(exp).getTime())) {
                    return true;
                } else {
                    alert('MFG must not exceed EXP');
                    return false;
                }      
            }
        </script>

        <c:set var="account" value="${sessionScope.ACCOUNT}"/>
        <c:set var="role" value="${account.role}"/>

        <!-- If account does not belong to the admin -->
        <c:if test="${role ne 1}">
            <c:redirect url="page_not_found"/>
        </c:if>

        <!-- else -->
        <c:if test="${role eq 1}">

            <!-- Navigate -->
            <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
                <img class="mb-2" src="img/moon-cake.svg" alt="" width="35" height="35">
                <h5 class="my-0 mr-md-auto font-weight-normal"><a href="index">Yellow Moon Shop</a></h5>
                <nav class="my-2 my-md-0 mr-md-3">
                    <a class="p-2 text-dark" href="index">Home page</a>
                </nav>
                <a class="btn btn-outline-primary" href="logout">Logout</a>
            </div>

            <div class="index-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
                <h1 class="display-4">Create a new product</h1>
            </div>

            <!-- Create a new product Form -->
            <div class="container">    
                <form action="create_product" method="POST" class="needs-validation" onsubmit="return validatedForm()"
                      id="addform" enctype="multipart/form-data">
                    <div class="mb-3">
                        <!-- Row 1: Name - Category -->
                        <div class="form-row">
                            <div class="form-group col-md-8 mb-3">
                                <label for="inputName">Name</label>
                                <input type="text" name="txtName" value="" class="form-control" id="inputName" required maxlength="255">
                            </div>
                            <div class="form-group col-md-4 mb-3">
                                <label for="inputCategory">Category</label>
                                <select name="cboCategory" id="inputCategory" class="custom-select" required>
                                    <option selected disabled value="">Choose...</option>
                                    <c:set var="categories" value="${sessionScope.CATEGORIES}"/>
                                    <c:forEach var="category" items="${categories}">
                                        <option>${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <!-- Row 2: Image -->
                        <div class="form-row mb-3">
                            <label for="inputImage">Image</label>
                            <input name="fileImage" value="" type="file" class="form-control" id="inputImage" required>  
                        </div> 
                        <!-- Row 3: Price - Quantity -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="inputPrice">Price</label>
                                <input type="number" name="txtPrice" value="" min="0" max="500000" 
                                       class="form-control" id="inputPrice" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="inputQuantity">Quantity</label>
                                <input type="number" name="txtQuantity" value="" min="1" max="1000" 
                                       class="form-control" id="inputQuantity" required>
                            </div>
                        </div>
                        <!-- Row 4: MFG - EXP-->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="inputMfg">MFG</label>
                                <input type="date" name="dateMfg" value="" class="form-control" 
                                       id="inputMfg" required>
                            </div>
                            <div class="form-group col-md-6">
<!--                                <div>
                                    <label for="inputExp" class="col-md-4">EXP</label>
                                    <div id="warning" class="col-md-8 text-danger"></div>
                                </div>-->
                                <label for="inputExp" class="col-md-4">EXP</label>
                                <input type="date" name="dateExp" value="" class="form-control" 
                                       id="inputExp" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-outline-primary">Create</button>
                    </div>
                </form>
            </div>
        </c:if>
    </body>
</html>
