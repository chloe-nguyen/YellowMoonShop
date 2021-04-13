
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
        <title>Check Out Page</title>
        <style>
            .container {
                max-width: 960px;
            }

            .lh-condensed { line-height: 1.25; }
        </style>
    </head>
    <body class="bg-light">
        <c:set var="account" value="${sessionScope.ACCOUNT}"/>
        <c:set var="role" value="${account.role}"/>

        <!-- If account belongs to the admin -->
        <c:if test="${role eq 1}">
            <c:redirect url="page_not_found"/>
        </c:if>

        <!-- else -->
        <c:if test="${role ne 1}">
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
                <div class="container">
                    <div class="py-5 text-center">
                        <h1>Checkout form</h1>
                    </div>

                    <div class="row">
                        <div class="col-md-4 order-md-2 mb-4">
                            <h4 class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted">Your cart</span>
                                <span class="badge badge-secondary badge-pill">${sessionScope.CART.totalQuantity} items</span>
                            </h4>

                            <ul class="list-group mb-3">
                                <c:forEach var="item" items="${cart}" varStatus="counter">
                                    <c:set var="product" value="${item.product}"/>
                                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                                        <div>
                                            <h6 class="my-0">${product.name}</h6>
                                            <small class="text-muted">${item.quantity} items</small>
                                        </div>
                                        <span class="text-muted">${product.price * item.quantity} vnd</span>
                                    </li>
                                </c:forEach>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Total (VND)</span>
                                    <strong>${sessionScope.CART.totalPrice}</strong>
                                </li>
                            </ul>
                        </div>

                        <div class="col-md-8 order-md-1">
                            <h4 class="mb-3">Billing address</h4>
                            <form action="checkout" class="needs-validation" novalidate>
                                <input type="hidden" name="txtUsername" value="${account.username}" />
                                <div class="mb-3">
                                    <label for="fullName">Full name</label>
                                    <input type="text" class="form-control" id="fullName" placeholder="Full Name" 
                                           name="txtFullname" value="${account.fullname}" required>
                                    <div class="invalid-feedback">
                                        Valid full name is required.
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" placeholder="1234 Main St" required
                                           name="txtAddress" value="${account.address}">
                                    <div class="invalid-feedback">
                                        Please enter your shipping address.
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="phoneNumber">Phone number</label>
                                    <input type="tel" class="form-control" name="txtPhone" value="${account.phone}"
                                           pattern="[0-9]{10}" id="phoneNumber" placeholder="0123456789" required>
                                    <div class="invalid-feedback">
                                        Please enter your phone number in the correct format.
                                    </div>
                                </div>

                                <hr class="mb-4">
                                <h4 class="mb-3">Payment</h4>
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="payment" checked disabled>
                                    <label class="custom-control-label" for="payment">Cash payment</label>
                                </div>

                                <hr class="mb-4">
                                <button class="btn btn-primary btn-lg btn-block" type="submit">Confirm</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
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


        <!--            <script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
                    <script src="js/bootstrap.bundle.min.js"></script>-->
        <script src="js/form-validation.js"></script>
    </body>
</html>
