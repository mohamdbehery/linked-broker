using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace BrokerNetwork.WebSite
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
                name: "Login",
                url: "Login",
                defaults: new { controller = "Home", action = "Login", id = UrlParameter.Optional }
            );
            routes.MapRoute(
                 name: "Forget",
                 url: "Forget",
                 defaults: new { controller = "Users", action = "ForgetPassword"}
             );
            routes.MapRoute(
                name: "LogOut",
                url: "LogOut",
                defaults: new { controller = "Home", action = "LogOut", id = UrlParameter.Optional }
            );
            routes.MapRoute(
                name: "Search",
                url: "Search",
                defaults: new { controller = "Home", action = "Search" }
            );
            routes.MapRoute(
                name: "Confirmation",
                url: "Confirmation",
                defaults: new { controller = "Users", action = "Confirmation", id = UrlParameter.Optional }
            );
            routes.MapRoute(
                name: "Profile",
                url: "Profile",
                defaults: new { controller = "Users", action = "MyProfile", id = UrlParameter.Optional }
            );
            routes.MapRoute(
                name: "ChangePassword",
                url: "ChangePassword",
                defaults: new { controller = "Users", action = "ChangePassword", id = UrlParameter.Optional }
            );
            routes.MapRoute(
                name: "VerficationRequest",
                url: "VerficationRequest",
                defaults: new { controller = "VerficationRequests", action = "VerficationRequest", id = UrlParameter.Optional }
            );
            routes.MapRoute(
              name: "SpecialOfferView",
              url: "SpecialOfferView",
              defaults: new { controller = "Home", action = "SpecialOfferView" }
          );
            routes.MapRoute(
                name: "RequestDetails",
                url: "RequestDetails/{id}",
                defaults: new { controller = "Home", action = "RequestDetails" }
            );
            routes.MapRoute(
                name: "RequestsList",
                url: "RequestsList",
                defaults: new { controller = "Home", action = "RequestsList" }
            );
            routes.MapRoute(
                name: "BrokersList",
                url: "BrokersList",
                defaults: new { controller = "Home", action = "BrokersList" }
            );
            
                routes.MapRoute(
                name: "ProjectDetails",
                url: "ProjectDetails/{id}",
                defaults: new { controller = "Home", action = "ProjectDetails" }
            );
            routes.MapRoute(
                name: "BrokerDetails",
                url: "BrokerDetails/{id}",
                defaults: new { controller = "Home", action = "BrokerDetails" }
            );
            routes.MapRoute(
                name: "PropertyDetails",
                url: "PropertyDetails/{id}",
                defaults: new { controller = "Home", action = "PropertyDetails" }
            );
            routes.MapRoute(
                name: "CompaniesList",
                url: "CompaniesList",
                defaults: new { controller = "Home", action = "CompaniesList" }
            );
            routes.MapRoute(
                name: "Landing",
                url: "Landing",
                defaults: new { controller = "Home", action = "Landing" }
            );
            routes.MapRoute(
                name: "CompanyDetails",
                url: "CompanyDetails/{id}",
                defaults: new { controller = "Home", action = "CompanyDetails" }
            );
            routes.MapRoute(
                name: "Register",
                url: "Register",
                defaults: new { controller = "Users", action = "Register" }
            );
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
