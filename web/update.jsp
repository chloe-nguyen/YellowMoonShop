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
        <title>Update Product Page</title>
    </head>
    <body>
        <script>
            function getImg(img) {
                var path = img.value;
                var start = path.lastIndexOf("\\");
                document.getElementById("showImg").src = 'img/' + path.substring(start + 1);
            }

            function changeStatus() {
                if (parseInt(document.getElementById("inputQuantity").value) === 0)
                    document.getElementById("inputStatus").selectedIndex = 0; //out-of-stock
                else document.getElementById("inputStatus").selectedIndex = 1; //available
            }
            
            function changeQuantity() {
                if (document.getElementById("inputStatus").selectedIndex === 0)
                    document.getElementById("inputQuantity").value = 0;
            }
            
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

            <!-- Header -->
            <div class="index-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
                <h1 class="display-4">Update product</h1>
            </div>

            <div class="container">
                <div class="card mb-5">
                    <div class="row">
                        <div class="col-md-5">
                            <img src="img/${param.txtImg}" id="showImg" class="card-img">
                        </div>

                        <!-- Form here -->
                        <div class="card-body col-md-6 mr-1">
                            <form action="update" method="POST" enctype="multipart/form-data" 
                                  onsubmit="return validatedForm()">
                                <div class="mb-3">
                                    <!-- Row 1: Name - Category -->
                                    <div class="form-row mb-3">
                                        <div class="form-group col-md-8">
                                            <label for="inputName">Name</label>
                                            <input type="text" name="txtName" value="${param.txtName}" class="form-control" id="inputName" required maxlength="255">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="inputCategory">Category</label>
                                            <select name="cboCategory" id="inputCategory" class="custom-select" required>
                                                <c:set var="categories" value="${sessionScope.CATEGORIES}"/>
                                                <c:forEach var="category" items="${categories}">
                                                    <option <c:if test="${param.cboCategory eq category.name}">selected</c:if> >
                                                        ${category.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- Row 2: Image -->
                                    <div class="form-row mb-3">
                                        <label for="inputImage">Image</label>
                                        <input name="fileImage" value="${param.txtImg}" type="file" onchange="getImg(this)"
                                               class="form-control" id="inputImage" >
                                        <input type="hidden" name="txtImage" value="${param.txtImg}" />
                                    </div> 
                                    <!-- Row 3: Price - Quantity - Status -->
                                    <div class="form-row mb-3">
                                        <div class="form-group col-md-4">
                                            <label for="inputPrice">Price</label>
                                            <input type="number" name="txtPrice" value="${param.txtPrice}" min="0" max="500000" 
                                                   class="form-control" id="inputPrice" required>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="inputQuantity">Quantity</label>
                                            <input type="number" name="txtQuantity" value="${param.txtQuantity}" min="0" max="1000" 
                                                   class="form-control" id="inputQuantity" required onchange="changeStatus()">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="inputStatus">Status</label>
                                            <select name="cboStatus" id="inputStatus" class="custom-select" required onchange="changeQuantity()">
                                                <option <c:if test="${param.txtStatus eq 0}">selected</c:if> >
                                                        Out of stock
                                                    </option>
                                                    <option <c:if test="${param.txtStatus eq 1}">selected</c:if> >
                                                        Available
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- Row 4: MFG - EXP -->
                                        <div class="form-row mb-3">
                                            <div class="form-group col-md-6">
                                                <label for="inputMfg">MFG</label>
                                                <input type="date" name="dateMfg" value="${param.txtMfg}" class="form-control" 
                                                   id="inputMfg" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="inputExp">EXP</label>
                                            <input type="date" name="dateExp" value="${param.txtExp}" class="form-control" 
                                                   id="inputExp" required onchange="">
                                        </div>
                                    </div>
                                    <input type="hidden" name="txtId" value="${param.txtId}" />
                                    <input type="hidden" name="txtUsername" value="${account.username}" />
                                    <button type="submit" class="btn btn-outline-primary">Update</button>
                                    <a class="btn btn-outline-primary" href="index">Cancel</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </body>
</html>
