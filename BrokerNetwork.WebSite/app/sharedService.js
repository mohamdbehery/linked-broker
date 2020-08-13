app.factory("SharedServices", function ($http) {
    var factory = [];
    factory.GetRegions = function (cityID,catID) {
        return $http.get("/api/Regions/" + cityID + "/" + catID);
    };
    factory.GetGroups = function (regionID) {
        return $http.get("/api/Groups/" + regionID);
    };
    factory.GetPatterns = function (regionID) {
        return $http.get("/api/Patterns/" + regionID);
    };
    factory.GetFinishLevels = function () {
        return $http.get("/api/FinishLevels");
    };
    factory.GetInstallmentTypes = function () {
        return $http.get("/api/InstallmentTypes");
    };
    factory.GetViews = function () {
        return $http.get("/api/Views");
    };
    factory.GetFloors = function () {
        return $http.get("/api/Floors");
    };
    return factory;
});