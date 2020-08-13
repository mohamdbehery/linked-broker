using BrokerNetwork.API;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace BrokerNetwork.WebSite
{
    public class SiteHelper
    {
        public static void SendConformation(string to, string type, string bodyText = null)
        {
            try
            {
                if (!string.IsNullOrEmpty(type))
                {
                    if (type == "confirm")
                    {
                        var encEmail = Encrypt.EncryptString(to);
                        bodyText = @" لتأكيد البريد الالكترونى من فضلك <a href=" + string.Format("{0}/Confirmation?code={1}", Helper.GetKeyValue("DomainUrl"), encEmail) + @" target=""_blank"">اضغط هنا </a> ";
                    }
                }
                var bodyTemplate = System.IO.File.ReadAllText(System.Web.HttpContext.Current.Request.MapPath("~/Templates/ConfirmEmail.html"));
                bodyTemplate = bodyTemplate.Replace("#body#", bodyText);
                Helper.SendMail(to, "LinkedBrokers", bodyTemplate);
            }
            catch (Exception ex)
            {
                File.AppendAllText(System.Web.HttpContext.Current.Request.MapPath("~/Logs/Mail.txt"), ex.ToString());

            }
        }
    }
}