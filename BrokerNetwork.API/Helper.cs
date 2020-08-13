using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace BrokerNetwork.API
{
    public class Helper
    {
        
        public static bool SendMail(string to, string subject, string body)
        {
            MailMessage msg = new MailMessage();
            msg.To.Add(to);
            MailAddress address = new MailAddress(GetKeyValue("Email"),"LinkedBroker");
            msg.From = address;
            msg.Subject = subject;
            msg.Body = body;
            msg.BodyEncoding = Encoding.UTF8;
            msg.IsBodyHtml = true;
            int b;
            bool z;
            SmtpClient client = new SmtpClient
            {
                Host = GetKeyValue("SMTPHost"),
                Credentials = new NetworkCredential(GetKeyValue("Email"), GetKeyValue("Password")),
                Port = int.TryParse(GetKeyValue("SMTPPort"), out b) ? b : 587,
                EnableSsl = bool.TryParse(GetKeyValue("EnableSSL"), out z) ? z : true,
                Timeout = 10000,
                UseDefaultCredentials = false
            };
            try
            {
                client.Send(msg);
            }
            catch (Exception ex)
            {
                File.AppendAllText(System.Web.HttpContext.Current.Request.MapPath("~/Logs/Mail.txt"), ex.ToString());
                return false;
            }
            return true;
        }


        public static string GetKeyValue(string key)
        {
            return ConfigurationManager.AppSettings[key];
        }
    }
}