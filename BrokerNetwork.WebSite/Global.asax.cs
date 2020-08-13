using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;
using BrokerNetwork.WebSite.App_Start;
using System.Web.Helpers;
using System.Security.Claims;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace BrokerNetwork.WebSite
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(System.Web.Optimization.BundleTable.Bundles);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            //WebApiConfig.Register(GlobalConfiguration.Configuration);
            AntiForgeryConfig.UniqueClaimTypeIdentifier = ClaimTypes.Sid;

            HttpConfiguration config = GlobalConfiguration.Configuration;
            //JsonSerializerSettings serializerSettings = new JsonSerializerSettings();
            //serializerSettings.Converters.Add(new IsoDateTimeConverter());
            //GlobalConfiguration.Configuration.Formatters[0] = new JsonNetFormatter(serializerSettings);
            config.Formatters.JsonFormatter
                        .SerializerSettings
                        .ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
            config.Formatters.JsonFormatter.SerializerSettings.Converters.Add(
    new IsoDateTimeConverter() { DateTimeFormat = "dd/MM/yyyy hh:mm" });
        }
    }
}