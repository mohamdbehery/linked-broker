using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using Owin;
using System;
using System.Data.Entity;
using System.Web.Http;
[assembly: OwinStartup(typeof(BrokerNetwork.WebSite.App_Start.Startup))]
namespace BrokerNetwork.WebSite.App_Start
{
    public partial class Startup
    {
        public static OAuthBearerAuthenticationOptions OAuthBearerOptions { get; private set; }

        public void Configuration(IAppBuilder app)
        {
            HttpConfiguration config = new HttpConfiguration();

            ConfigureOAuth(app);

            WebApiConfig.Register(config);
            //app.UseCors(Microsoft.Owin.Cors.CorsOptions.AllowAll);
            //app.UseWebApi(config);
            //Database.SetInitializer(new MigrateDatabaseToLatestVersion<MadentyDAL.Mapping.MadentyContext, MadentyDAL.Migrations.Configuration>());

        }

        
    }
}
