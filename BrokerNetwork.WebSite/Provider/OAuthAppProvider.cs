using Microsoft.Owin.Security;
using Microsoft.Owin.Security.OAuth;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Linq;
using BrokerNetwork.WebSite.App_Start;
using BrokerNetwork.Models.Business;

namespace BrokerNetwork.WebSite.Provider
{
    public class OAuthAppProvider : OAuthAuthorizationServerProvider
    {
        private Dictionary<string, string> Additional;
        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            //if (context.ClientId == null)
            //{
                context.Validated();
            //}
            //return Task.FromResult<object>(null);
        }
        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            if (Additional != null)
            {
                foreach (var row in Additional)
                    context.AdditionalResponseParameters.Add(row.Key, row.Value);
            }
            return base.TokenEndpoint(context);
        }
        public override Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            //context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { "*" });
            return Task.Factory.StartNew(()=> {
                var userName = context.UserName;
                var password = context.Password;
                var user = BLayer.GetUserByLogin(userName, password);
                if (user != null)
                {
                    var clams = new List<Claim>()
                    {
                        new Claim(ClaimTypes.Email, user.Email)
                        , new Claim(ClaimTypes.Role, user.UserGroupName)
                        , new Claim(ClaimTypes.Sid,user.UserID.ToString())
                        ,new Claim(ClaimTypes.Name, user.FullName)
                        ,new Claim(ClaimTypes.Country, user.ProfileImgPath)
                    };
                    var identity = new ClaimsIdentity(clams, Startup.OAuthOptions.AuthenticationType);
                    Additional = new Dictionary<string, string>();
                    Additional.Add("Role", user.UserGroupName);
                    Additional.Add("Name", user.FullName);
                    Additional.Add("UserID", user.UserID.ToString());
                    context.Validated(new AuthenticationTicket(identity, new AuthenticationProperties() { }));
                }
                else
                {
                    context.SetError("Invalid ", "Email Or Password Error");
                }
            });
        }
    }
}