
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
        <title>Yellow Moon Shop</title>
        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>

        <c:set var="account" value="${sessionScope.ACCOUNT}"/>
        <c:set var="role" value="${account.role}"/>

        <!-- Navigate -->
        <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
            <img class="mb-2" src="img/moon-cake.svg" alt="" width="35" height="35">
            <h5 class="my-0 mr-md-auto font-weight-normal"><a href="index">Yellow Moon Shop</a></h5>
            <nav class="my-2 my-md-0 mr-md-3">
                <c:if test="${role eq 1}">
                    <a class="p-2 text-dark" href="create_product_page">Create Cake</a>
                </c:if>

                <c:if test="${role eq 2}">
                    <a class="p-2 text-dark" href="#">Track Orders</a>
                    <a class="p-2 text-dark" href="cart_page">Cart</a>
                </c:if>

                <c:if test="${empty account}">
                    <a class="p-2 text-dark" href="cart_page">Cart</a>
                </c:if>
            </nav>

            <c:if test="${not empty account}">
                <a class="btn btn-outline-primary" href="logout">Logout</a>
            </c:if>

            <c:if test="${empty account}">
                <a class="btn btn-outline-primary" href="login_page">Login</a>
            </c:if>


        </div>

        <div class="index-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
            <h1 class="display-4">Welcome ${account.fullname}</h1>
            <p class="lead">Yellow Moon Shop is a family-owned store in Ho Chi Minh City in which customers could enjoy our delicious moon cakes</p>
        </div>

        <!-- Search field -->
        <form action="search" method="POST">
            <div class="container py-3 my-3">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">

                            <!-- Search by productName -->
                            <div class="col-md-4">
                                <div class="form-group ">
                                    <input name="txtSearchValue" value="${param.txtSearchValue}" 
                                           class="form-control" placeholder="What are you looking for?"/>
                                </div>
                            </div>

                            <!--Search by price-->
                            <c:set var="priceRange" value="${sessionScope.PRICE_RANGE}"/>
                            <c:if test="${not empty priceRange}">
                                <div class="col-md-3">
                                    <div class="form-group ">
                                        <select id="inputState" class="form-control" name="cboPrice" >
                                            <option selected>Price</option>
                                            <c:forEach var="price" items="${priceRange}">
                                                <option <c:if test="${param.cboPrice eq price}">selected</c:if> >
                                                    ${price}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </c:if>

                            <!--Search by category-->                
                            <c:set var="categories" value="${sessionScope.CATEGORIES}"/>
                            <c:if test="${not empty categories}">
                                <div class="col-md-3">
                                    <div class="form-group ">
                                        <select id="inputState" class="form-control" name="cboCategory" >
                                            <option selected>Category</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option <c:if test="${param.cboCategory eq category.name}">selected</c:if> >
                                                    ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </c:if>
                            <div class="col-md-2">
                                <input type="hidden" name="pageNumber" value="1" />
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- List of products -->
        <c:set var="list" value="${sessionScope.LIST_PRODUCT}"/>
        <c:if test="${empty list}">
            <div class="container">
                <img src="img/no_results_found.png"/>
            </div>
        </c:if>

        <c:if test="${not empty list}">
            <div class="container">
                <div class="card-deck mb-3 text-center">
                    <c:forEach var="dto" items="${list}">
                        <div class="card mb-3 shadow-sm col-md-4">
                            <img src="img/${dto.img}" class="card-img-top">
                            <div class="card-header">
                                <h4 class="my-0 font-weight-normal">${dto.name}</h4>
                            </div>
                            <div class="card-body">
                                <h1 class="card-title pricing-card-title">${dto.price} <small class="text-muted">vnd</small></h1>
                                <ul class="list-unstyled mt-3 mb-4">                                    
                                    <li>Quantity: ${dto.quantity}</li>
                                    <li>MFG: ${dto.mfg}</li>
                                    <li>EXP: ${dto.exp}</li>  
                                    <c:if test="${role eq 1}">   
                                        <li>Category: 
                                            <c:forEach var="category" items="${categories}">
                                                <c:if test="${dto.category eq category.id}">
                                                    ${category.name}
                                                </c:if>    
                                            </c:forEach>
                                        </li>                                        
                                        <c:if test="${dto.status eq 0}"><li>Status: Out of stock</li></c:if>
                                        <c:if test="${dto.status eq 1}"><li>Status: Available</li></c:if>
                                    </c:if>
                                </ul>

                                <c:if test="${role ne 1}">
                                    <form action="add_to_cart">
                                        <input type="hidden" name="txtId" value="${dto.id}" />
                                        <input type="hidden" name="txtName" value="${dto.name}" />
                                        <input type="hidden" name="txtImg" value="${dto.img}" />
                                        <input type="hidden" name="txtPrice" value="${dto.price}" />
                                        <input type="hidden" name="txtQuantity" value="${dto.quantity}" />
                                        <input type="hidden" name="txtMfg" value="${dto.mfg}" />
                                        <input type="hidden" name="txtExp" value="${dto.exp}" />
                                        <input type="hidden" name="txtStatus" value="${dto.status}" />
                                        <input type="hidden" name="txtCategory" value="${dto.category}" />
                                        <button type="submit" class="btn btn-lg btn-block btn-outline-primary">Add to cart</button>
                                    </form>
                                </c:if>
                                
                                <c:if test="${role eq 1}">
                                    <form action="update_page" method="POST">
                                        <input type="hidden" name="txtId" value="${dto.id}" />
                                        <input type="hidden" name="txtName" value="${dto.name}" />
                                        <input type="hidden" name="txtImg" value="${dto.img}" />
                                        <input type="hidden" name="txtPrice" value="${dto.price}" />
                                        <input type="hidden" name="txtQuantity" value="${dto.quantity}" />
                                        <input type="hidden" name="txtMfg" value="${dto.mfg}" />
                                        <input type="hidden" name="txtExp" value="${dto.exp}" />
                                        <input type="hidden" name="txtStatus" value="${dto.status}" />
                                        <input type="hidden" name="txtCategory" value="${dto.category}" />
                                        <button type="submit" class="btn btn-lg btn-block btn-outline-primary">Update</button>
                                    </form>
                                </c:if>

                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Pagination -->
        <c:set var="productPerPage" value="${21}"/>
        <c:set var="totalProduct" value="${sessionScope.TOTAL_PRODUCT}"/>
        <c:if test="${totalProduct ge productPerPage}">
            <!-- 22 products => 2 pages -->
            <c:set var="totalPage" value="${Math.round(totalProduct div productPerPage) + 1}"/>

            <!-- 21 products => 1 page -->
            <c:if test="${totalProduct mod productPerPage eq 0}">
                <c:set var="totalPage" value="${Math.round(totalProduct div productPerPage)}"/>
            </c:if>

            <!-- Display pages -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:forEach var="i" begin="1" end="${totalPage}">
                        <c:url var="index" value="search">
                            <c:param name="btnAction" value="Pagination"/>
                            <c:param name="pageNumber" value="${i}"/>
                            <c:param name="txtSearchValue" value="${param.txtSearchValue}"/>
                            <c:param name="cboPrice" value="${param.cboPrice}"/>
                            <c:param name="cboCategory" value="${param.cboCategory}"/>
                        </c:url>
                        <li class="page-item"><a class="page-link" href="${index}">${i}</a></li>
                        </c:forEach>
                </ul>
            </nav>
        </c:if>

        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" 
                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" 
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" 
                integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" 
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" 
                integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" 
        crossorigin="anonymous"></script>
    </body>
</html>
