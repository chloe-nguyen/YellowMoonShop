
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" 
              integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" 
              crossorigin="anonymous">
        <title>Show Bill Page</title>
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
                <c:set var="uid" value="${sessionScope.UID_CART}"/>
                <div class="container">
                    <div class="py-5 text-center">
                        <h1>Order Successfully</h1>
                    </div>

                    <table class="table table-striped">
                        <tbody>
                            <tr>
                                <th scope="row">ID</th>
                                <td>${uid}</td>
                            </tr>
                            <tr>
                                <th scope="row">Full Name</th>
                                <td>${param.txtFullname}</td>
                            </tr>
                            <tr>
                                <th scope="row">Phone number</th>
                                <td>${param.txtPhone}</td>
                            </tr>
                            <tr>
                                <th scope="row">Address</th>
                                <td>${param.txtAddress}</td>
                            </tr>
                        </tbody>
                    </table>

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Item</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th scope="col">Sum</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cart}" varStatus="counter">
                                <c:set var="product" value="${item.product}"/>
                                <tr>
                                    <th scope="row">${counter.count}</th>
                                    <td>${product.name}</td>
                                    <td>${item.quantity}</td>
                                    <td>${product.price}</td>
                                    <td>${product.price * item.quantity}</td>
                                </tr>
                            </c:forEach>
                                <tr class="text-center">
                                <th scope="row" colspan="2">Total</th>
                                <td colspan="3">${sessionScope.CART.totalPrice}</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="text-center pb-md-5">
                        <a class="btn btn-outline-primary" href="successOrder">Back to Home Page</a>
                    </div>
                </div>

            </c:if>
        </c:if>
    </body>
</html>
