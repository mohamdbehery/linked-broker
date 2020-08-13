app.factory("customersServices", function ($http) {
    var factory = [];
    factory.DeleteCustomer = function (customerID) {
        return $http.post("/api/DeleteCustomers/" +customerID);
    };
    
    return factory;
});