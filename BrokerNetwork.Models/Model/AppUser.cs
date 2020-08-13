using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class AppUser : ClaimsPrincipal
    {
        #region ctor

        public AppUser(ClaimsPrincipal principal)
            : base(principal)
        {
        }

        #endregion

        #region Properties
        public string Name
        {
            get
            {
                if (Claims == null)
                    return string.Empty;
                return this.FindFirst(ClaimTypes.Name).Value;
            }
        }

        public string Country
        {
            get
            {
                return this.FindFirst(ClaimTypes.Country).Value;
            }
        }
        public string Email
        {
            get
            {
                return this.FindFirst(ClaimTypes.Email).Value;
            }
        }
        public string Role
        {
            get
            {
                var clam = FindFirst(ClaimTypes.Role);
                if (clam == null) return string.Empty;
                return clam.Value;
            }
        }
        public string ProfileImage
        {
            get
            {
                var clam = FindFirst(ClaimTypes.Country);
                if (clam == null) return string.Empty;
                return clam.Value;
            }
        }
        public long UserID
        {
            get
            {
                long id = 0;
                var objID = this.FindFirst(ClaimTypes.Sid);
                //if(objID!=null)
                //{
                    string val = objID.Value;
                    long.TryParse(val, out id);
                //}
                return id;
            }
        }
        public bool IsVerfied
        {
            get
            {
                bool id = false;
                string val = this.FindFirst(ClaimTypes.PostalCode).Value;
                bool.TryParse(val, out id);

                return id;
            }
        }

        #endregion

    }
}
