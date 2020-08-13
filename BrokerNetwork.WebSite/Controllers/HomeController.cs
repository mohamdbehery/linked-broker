using BrokerNetwork.Models;
using BrokerNetwork.Models.Model;
using BrokerNetwork.WebSite.Models;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.Mvc;
using System.Collections.Generic;
using BrokerNetwork.Models.Business;

namespace BrokerNetwork.WebSite.Controllers
{
    public class HomeController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();
        
        private void InitSearchLookups()
        {
            var regions = db.Locations.Where(x => x.IsActive && !x.IsDeleted && x.LocationID > 4).Select(x => new { x.LocationID, x.LocationName }).ToList();
            regions.Insert(0, new { LocationID = 0, LocationName = "اختر" });
            ViewBag.Regions = new SelectList(regions, "LocationID", "LocationName");

            var propertytypes = db.PropertyTypes.Where(x => x.IsActive && !x.IsDeleted).Select(x => new { x.PropertyTypeID, x.PropTypeTitle }).ToList();
            propertytypes.Insert(0, new { PropertyTypeID = 0, PropTypeTitle = "اختر" });
            ViewBag.PropertyTypes = new SelectList(propertytypes, "PropertyTypeID", "PropTypeTitle");

            var floorTypes = db.PropertyFloorTypes.Where(x => x.IsActive && !x.IsDeleted).Select(x => new { x.PropertyFloorTypeID, x.FloorTypeTitle }).ToList();
            floorTypes.Insert(0, new { PropertyFloorTypeID = 0, FloorTypeTitle = "اختر" });
            ViewBag.FloorTypes = new SelectList(floorTypes, "PropertyFloorTypeID", "FloorTypeTitle");

            var projectTypes = db.ProjectTypes.Where(x => x.IsActive == true && x.IsDeleted != true).Select(x => new { x.ProjectTypeID, x.ProjectTypeName }).ToList();
            projectTypes.Insert(0, new { ProjectTypeID = 0, ProjectTypeName = "اختر" });
            ViewBag.ProjectTypes = new SelectList(projectTypes, "ProjectTypeID", "ProjectTypeName");

        }
        // GET: Home
        [AllowAnonymous]
        public ActionResult Index(FilterList<PropertyShortDisplay> filter)
        {
            if (User.Identity.IsAuthenticated)
                return RedirectToAction("Landing");
            //filter.isV = !string.IsNullOrEmpty(Request.QueryString["isV"]) && Request.QueryString["isV"].Equals("on") ? true : false;
            //ViewBag.PropertyTypes = db.PropertyTypes.ToList()[].PropTypeTitle;
            InitSearchLookups();
            var rows = new BLayer().GetAllPropertiesLanding(filter, PropertiesDisplayType.Visitor);
            return View(rows);
        }
        public ActionResult Landing(FilterList<PropertyShortDisplay> filter)
        {
            InitSearchLookups();
            var rows = new BLayer().GetAllPropertiesLanding(filter, PropertiesDisplayType.AllBrokers);
            return View(rows);
        }
        public ActionResult BrokersList()
        {
            var rows = db.Users.Where(x => x.IsActive && !x.IsDeleted);
            return View(rows);
        }
        public ActionResult Search(string SearchText)
        {
            var rows = db.Users.Where(x => x.IsActive && !x.IsDeleted);
            var searchtext = Request.QueryString["SearchText"];
            if (!string.IsNullOrEmpty(SearchText))
                rows = rows.Where(x => x.FullName.Contains(SearchText) || x.Mobile.Contains(searchtext));
            return View(rows);
        }
        public ActionResult CompaniesList()
        {
            var rows = db.Companies.Where(x => x.IsActive && !x.IsDeleted).ToList();
            return View(rows);
        }
        public ActionResult RequestsList()
        {
            //var rows = new BLayer().GetAllPropertiesRequests(0);
            var filter = new FilterList<PropertyShortDisplay>();
            int num, size;
            filter.PageNum = int.TryParse(Request.QueryString["PageNum"], out num) ? num : filter.PageNum;
            filter.PageSize = int.TryParse(Request.QueryString["PageSize"], out size) ? size : filter.PageSize;
            var rows = new BLayer().GetAllPropertiesRequests(filter);
            return View(filter);
        }
        public ActionResult CompanyDetails(int id)
        {
            var query = db.Companies.Where(x => !x.IsDeleted && x.CompanyID == id);
            if(!CurrentUser.Role.Equals("Admin") && !CurrentUser.Role.Equals("SuperAdmin"))
            {
                query = query.Where(x => x.IsActive);
            }
            var rows = query.FirstOrDefault();
            if (rows != null && rows.Projects != null && rows.Projects.Count > 0)
            {
                var idsList = rows.Projects.Select(z => z.ProjectID).ToList();
                ViewBag.Images = db.Files.Where(x => idsList.Contains((int)x.ParentID)).ToList();
            }
            return View(rows);
        }
        public ActionResult ProjectDetails(int id)
        {
            var rows = db.Projects.Where(x => !x.IsDeleted && x.IsActive && x.ProjectID == id).FirstOrDefault();
            if (rows != null && rows.Properties != null && rows.Properties.Count > 0)
            {
                var idsList = rows.Properties.Select(z => z.PropertyID).ToList();
                ViewBag.ProjectImg = db.Files.Where(x => x.ParentID == rows.ProjectID && x.IsActive == true && x.IsDeleted == false && x.ParentType == "Projects").FirstOrDefault();
                ViewBag.Images = db.Files.Where(x => idsList.Contains((int)x.ParentID) && x.IsActive == true && x.IsDeleted == false && x.ParentType == "Properties").ToList();
                ViewBag.Properties = rows.Properties.Where(x => x.IsActive && !x.IsDeleted && x.SharedID == "All").ToList();
            }
            return View(rows);
        }
        [AllowAnonymous]
        public ActionResult PropertiesList()
        {
            //var rows = db.Properties.Where(x => !x.IsDeleted && x.IsActive && x.AllowVisitors == true);
            //var rows = new BLayer().GetAllPropertiesLanding(0,PropertiesDisplayType.Visitor);
            return View();
        }
        [AllowAnonymous]
        public ActionResult PropertyDetails(int id)
        {
            //var rows = db.Properties.Where(x => !x.IsDeleted && x.IsActive && x.AllowVisitors == true);
            var rows = new BLayer().GetPropertyDetails(id);
            if (rows == null) return RedirectToAction("Index");
            return View(rows);
        }
        public ActionResult SpecialOfferView()
        {
            var rows = db.SpecialOffers.Where(x => !x.IsDeleted && x.IsActive).OrderByDescending(x=>x.OfferID);
            return View(rows);
        }
        public ActionResult RequestDetails(int id)
        {
            //var rows = db.Properties.Where(x => !x.IsDeleted && x.IsActive && x.AllowVisitors == true);
            var rows = new BLayer().GetRequestDetails(id);

            return View(rows);
        }
        public ActionResult BrokerDetails(int id)
        {
            //var rows = db.Properties.Where(x => !x.IsDeleted && x.IsActive && x.AllowVisitors == true);
            var rows = db.Users.Where(x => x.IsActive && x.UserID == id).FirstOrDefault();
            //Broker Properties
            var filterProperties = new FilterList<PropertyShortDisplay>();
            filterProperties.ByUserID = id;
            filterProperties.ShowPagingButtons = false;
            ViewBag.BrokerProperties = new BLayer().GetAllPropertiesLanding(filterProperties, PropertiesDisplayType.SpecificUser);
            //Broker Requests
            var filter = new FilterList<PropertyShortDisplay>();
            filter.ByUserID = id;
            ViewBag.BrokerRequests = new BLayer().GetAllPropertiesRequests(filter);
            return View(rows);
        }
        [AllowAnonymous]
        public ActionResult Login()
        {
            //var users = db.Users.ToList();
            //foreach (var u in users)
            //    u.UserPassword = Encrypt.EncryptString(u.UserPassword);
            //db.SaveChanges();
            if(Request.IsAuthenticated)
                return Redirect(GetRedirectUrl(""));
            return View(new LoginModel());
        }
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(LoginModel model)
        {
            if (model == null || string.IsNullOrEmpty(model.Provider)) return View(model);
            if (!ModelState.IsValid && !model.Provider.Equals("FaceBook", System.StringComparison.OrdinalIgnoreCase)) //Checks if input fields have the correct format
            {
                return View(model); //Returns the view with the input values so that the user doesn't have to retype again
            }

            User user;
            if (model.Provider.Equals("FaceBook", System.StringComparison.OrdinalIgnoreCase))
                user = db.Users.Where(x => x.ProviderID == model.ProviderID && x.Provider == model.Provider && x.IsActive == true).FirstOrDefault();
            else
            {
                model.Password = Encrypt.EncryptString(model.Password);
                user = db.Users.Where(x => x.Email == model.Email && x.UserPassword == model.Password && x.IsActive == true && x.Provider == model.Provider).FirstOrDefault();
            }
            if (user != null)
            {
                if (!user.IsConfirmed)
                {
                    SiteHelper.SendConformation(user.Email, "confirm");
                    ViewBag.Msg = "ارجو تأكيد البريد الالكترونى أولا قبل تسجيل الدخول";
                    return View(model);
                }
                var identity = new ClaimsIdentity(new[] { new Claim(ClaimTypes.Name, user.FullName)
                    , new Claim(ClaimTypes.Email, user.Email)
                , new Claim(ClaimTypes.Sid,user.UserID.ToString())
                ,new Claim(ClaimTypes.Role,user.UserGroupName)}, "ApplicationCookie");
                if (!string.IsNullOrEmpty(user.ProfileImgPath))
                    identity.AddClaim(new Claim(ClaimTypes.Country, user.ProfileImgPath));
                if (user.IsVerfied.HasValue)
                    identity.AddClaim(new Claim(ClaimTypes.PostalCode, user.IsVerfied.ToString()));
                else
                    identity.AddClaim(new Claim(ClaimTypes.PostalCode, false.ToString()));
                var ctx = Request.GetOwinContext();
                var authManager = ctx.Authentication;
                authManager.SignIn(identity);

                return Redirect(GetRedirectUrl(model.ReturnUrl));
            }
            if(model.Provider.Equals("FaceBook", System.StringComparison.OrdinalIgnoreCase))
            {
                return View("~/Views/Users/Register.cshtml", new RegisterModel() { Provider=model.Provider,FullName=model.Email,ProviderID=model.ProviderID});
            }
            ViewBag.Msg = " لا يوجد مستخدم بهذه البيانات أرجو المحاولة مرة اخرى ";
            //ModelState.AddModelError("", "Exeption");
            return View(model); //Should always be declared on the end of an action method
        }
        private string GetRedirectUrl(string returnUrl)
        {
            if (string.IsNullOrEmpty(returnUrl) || !Url.IsLocalUrl(returnUrl))
            {
                return Url.Action("Landing", "Home");
            }
            return returnUrl;
        }

        public ActionResult LogOut()
        {
            var ctx = Request.GetOwinContext();
            var authManager = ctx.Authentication;

            authManager.SignOut("ApplicationCookie");
            return RedirectToAction("index", "home");
        }
        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }
    }
}