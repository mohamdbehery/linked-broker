using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace BrokerNetwork.WebSite.Models
{
    public class LoginModel
    {
        public LoginModel()
        {
            Provider = "LinkedBroker";
        }
        [Required]
        //[DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [HiddenInput(DisplayValue = false)]
        public string ReturnUrl { get; set; }

        [HiddenInput(DisplayValue = false)]
        public string Provider { get; set; }

        [HiddenInput(DisplayValue = false)]
        public string ProviderID { get; set; }
    }
}
