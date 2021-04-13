
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
        <title>Cart Page</title>
        <link href="css/index.css" rel="stylesheet">
    </head>
    <body>

        <c:set var="account" value="${sessionScope.ACCOUNT}"/>
        <c:set var="role" value="${account.role}"/>

        <!-- If account belongs to the admin -->
        <c:if test="${role eq 1}">
            <c:redirect url="page_not_found"/>
        </c:if>

        <!-- else -->
        <c:if test="${role ne 1}">
            <!-- Navigate -->
            <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
                <img class="mb-2" src="img/moon-cake.svg" alt="" width="35" height="35">
                <h5 class="my-0 mr-md-auto font-weight-normal"><a href="index">Yellow Moon Shop</a></h5>
                <nav class="my-2 my-md-0 mr-md-3">
                    <a class="p-2 text-dark" href="index">Home page</a>
                </nav>
                <c:if test="${not empty account}">
                    <a class="btn btn-outline-primary" href="logout">Logout</a>
                </c:if>

                <c:if test="${empty account}">
                    <a class="btn btn-outline-primary" href="login_page">Login</a>
                </c:if>
            </div>

            <!-- List items -->
            <c:set var="cart" value="${sessionScope.CART.cart}"/>
            <c:if test="${empty cart}">
                <div class="index-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
                    <h1 class="display-4">Your cart is empty</h1>
                </div>
                <div class="container text-center">
                    <img class="mb-2" src="img/empty-cart.svg" alt="" width="300" height="300"><br/>            
                    <a class="p-2 text-primary" href="index">Shopping now</a>
                </div>
            </c:if>

            <c:if test="${not empty cart}">
                <!-- Header -->
                <div class="index-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
                    <h1 class="display-4">Your Cart</h1>
                </div>

                <div class="container">
                    <c:forEach var="item" items="${cart}" varStatus="counter">
                        <c:set var="product" value="${item.product}"/>
                        <div class="card mb-3">
                            <div class="row no-gutters">
                                <div class="col-md-3">
                                    <img src="img/${product.img}" class="card-img">
                                </div>
                                <div class="col-md-7">
                                    <div class="card-body">
                                        <h5 class="card-title">${product.name}</h5>
                                        <div class="row">
                                            <label for="productPrice" class="col-3 col-form-label">Price</label>
                                            <div class="col-9">
                                                <input type="text" readonly class="form-control-plaintext" 
                                                       id="productPrice" value="${product.price}">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label for="inputQuantity" class="col-3 col-form-label">Quantity</label>      
                                            <div class="col-9">
                                                <form action="update_item_quantity" id="formUpdateQuantity" class="needs-validation">
                                                    <input type="hidden" name="txtId" value="${product.id}" />
                                                    <input id="inputQuantity" class="form-control-plaintext" 
                                                           min="1" max="${product.quantity}" required
                                                           type="number" name="txtQuantity" value="${item.quantity}"
                                                           onchange="submit()">
                                                    <c:if test="${sessionScope.INVALID_QUANTITY}">
                                                        <p class="text-danger">Please input a value from 1 to ${product.quantity}</p>
                                                    </c:if>
                                                </form>
                                            </div>          
                                        </div>
                                        <div class="row">
                                            <label for="total" class="col-3 col-form-label">Total</label>
                                            <div class="col-9">
                                                <input type="text" readonly class="form-control-plaintext" 
                                                       id="total" value="${product.price * item.quantity}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2 align-self-center">
                                    <form action="remove">
                                        <input type="hidden" name="txtId" value="${product.id}" />
                                        <button type="submit" class="btn btn-outline-danger" 
                                                onclick="return confirm('Do you want to remove this item?')">
                                            Remove
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="text-center pb-md-5">
                        <c:if test="${sessionScope.INVALID_QUANTITY}">
                            <a class="btn btn-outline-primary" href="#">Check out</a>
                        </c:if>

                        <c:if test="${not sessionScope.INVALID_QUANTITY}">
                            <a class="btn btn-outline-primary" href="checkout_page">Check out</a>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </c:if>
    </body>
</html>
