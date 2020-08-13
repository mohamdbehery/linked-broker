using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace BrokerNetwork.WebSite.Models
{
    public class RegisterModel
    {
        public RegisterModel()
        {
            Provider = "LinkedBroker";
        }
        [Required(ErrorMessage ="أرجو إدخال الاسم كامل ")]
        [DataType(DataType.Text)]
        public string FullName { get; set; }

        [Required(ErrorMessage ="أرجو إدخال البريد الالكترونى")]
        //[RegularExpression(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$",ErrorMessage ="Error")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        //[Required(ErrorMessage = "أرجو أختيار صورة للبروفايل")]
        public bool ProfileImgPath { get; set; }
        [Required(ErrorMessage = "أرجو إدخال رقم الموبايل")]
        [DataType(DataType.PhoneNumber)]
        public string Mobile { get; set; }
        [Required(ErrorMessage = "أرجو إدخال كلمة المرور")]
        [MinLength(6,ErrorMessage ="يجب أن تكون كلمة المرور أكبر من 6 أحرف")]
        [DataType(DataType.Password)]
        public string UserPassword { get; set; }

        [MinLength(6, ErrorMessage = "يجب أن تكون كلمة المرور أكبر من 6 أحرف")]
        [Required(ErrorMessage = "ارجو إدخال تأكيد كلمة المرور")]
        [DataType(DataType.Password)]
        [System.ComponentModel.DataAnnotations.Compare("UserPassword", ErrorMessage = "الباسورد غير متوافق")]
        public string ConfirmPassword { get; set; }
        public string Notes { get; set; }

        [HiddenInput(DisplayValue = false)]
        public string Provider { get; set; }

        [HiddenInput(DisplayValue = false)]
        public string ProviderID { get; set; }

    }
}
