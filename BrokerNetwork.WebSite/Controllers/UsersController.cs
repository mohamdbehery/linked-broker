using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Web;
using System.Web.Mvc;
using BrokerNetwork.API;
using BrokerNetwork.Models;
using BrokerNetwork.Models.Model;
using BrokerNetwork.WebSite.Models;

namespace BrokerNetwork.WebSite.Controllers
{
    public class UsersController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;

            ViewBag.LocationID = new SelectList(db.Locations, "LocationID", "LocationName");
        }

        // GET: Users
        public ActionResult Index()
        {
            var users = db.Users.Include(u => u.Company);
            return View(users.Where(x => x.IsDeleted == false && x.IsActive == true && x.ByUserID == 1).ToList());
        }

        // GET: Users/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }
        [AllowAnonymous]
        public ActionResult Confirmation(string code)
        {
            ViewBag.Success = false;
            if (!string.IsNullOrEmpty(code))
            {
                try
                {
                    var email = Encrypt.DecryptString(code);
                    if(!string.IsNullOrEmpty(email))
                    {
                        var existUser = db.Users.Where(c => c.Email == email).FirstOrDefault();
                        if(existUser!=null)
                        {
                            existUser.IsConfirmed = true;
                            db.SaveChanges();
                            ViewBag.Success = true;
                            ViewBag.Conf = string.Format("تم تأكيد البريد الالكترونى {0} وتفعيل حسابكم , تستطيع الان استخدام مزايانا بتسجيل الدخول", email) ;
                        }
                    }
                }
                catch (Exception ex)
                {
                }
            }
            return View();
        }
        [AllowAnonymous]
        public ActionResult Register()
        {
            var model = new RegisterModel();
            if (User.Identity.IsAuthenticated)
                return RedirectToAction("Landing","Home");
            ViewBag.LocationID = new SelectList(db.Locations, "LocationID", "LocationName");
            return View(model);
        }
        
        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register([Bind(Include = "FullName,Email,Mobile,UserPassword,FavouriteLocationIDs,Notes,Provider,ProviderID")] RegisterModel user, HttpPostedFileBase fuPersonalImage)
        {
            //return View();
            var userExist = db.Users.Where(x => x.Email == user.Email || (x.Provider.Equals("FaceBook") && x.ProviderID==user.ProviderID)).FirstOrDefault();
            if (userExist != null)
            {
                ViewBag.Msg = "عفوا .. يوجد مستخدم مسجل من قبل بنفس الحساب الذى ادخلته";
                return View();
            }
            var newUser = new User();
            newUser.EntryDate = DateTime.Now;
            newUser.IsActive = true;
            newUser.IsConfirmed = false;
            newUser.IsDeleted = false;
            newUser.UserGroupName = "User";
            newUser.Email = user.Email;
            newUser.Mobile = user.Mobile;
            newUser.Notes = user.Notes;
            newUser.FullName = user.FullName;
            newUser.Provider = user.Provider;
            newUser.ProviderID = user.ProviderID;
            if (user.Provider.Equals("FaceBook", StringComparison.OrdinalIgnoreCase))
            {
                newUser.UserPassword = "";
                newUser.IsConfirmed = true;
            }
            else
            {
                newUser.UserPassword = Encrypt.EncryptString(user.UserPassword);
            }
            if (fuPersonalImage != null)
            {
                var FileName = fuPersonalImage.FileName;
                var FullPath = Request.MapPath("~/Uploads/PersonalImages/" + FileName);
                fuPersonalImage.SaveAs(FullPath);
                newUser.ProfileImgPath = FileName;
            }
            db.Users.Add(newUser);
            db.SaveChanges();
            if (!newUser.IsConfirmed)
                SiteHelper.SendConformation(user.Email, "confirm");
            return RedirectToAction("Login", "Home");
        }

        [AllowAnonymous]
        public ActionResult ForgetPassword()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ForgetPassword([Bind(Include = "Email")] LoginModel user)
        {
            ViewBag.alert = "alert-danger";
            if (ModelState.IsValidField("Email"))
            {
                var userExist = db.Users.Where(x => x.Email == user.Email).FirstOrDefault();
                if (userExist == null)
                {
                    ViewBag.Msg = "عفوا .. لا يوجد مستخدم مسجل من قبل بهذا البريد الالكترونى";
                    return View(user);
                }
                else
                {
                    if (!userExist.Provider.Equals("LinkedBroker", StringComparison.OrdinalIgnoreCase))
                    {
                        ViewBag.Msg = "هذا المستخدم مسجل عبر مواقع التواصل الاجتماعى ولا يملك كلمة مرور لاسترجاعها";
                        return View(user);
                    }
                    if (!userExist.IsActive)
                    {
                        ViewBag.Msg = "عفوا .. هذا الحساب موقوف مؤقتا من فضلك قم بالاتصال بمدير الموقع لاعادة تفعيله ";
                    }
                    else
                    {
                        SiteHelper.SendConformation(user.Email, "forget", "كلمة المرور الخاصة بحسابك هى: " + Encrypt.DecryptString(userExist.UserPassword));
                        ViewBag.Msg = "تم ارسال كلمة المرور الخاصة بحسابك على البريد الالكترونى الذى ادخلته";
                        ViewBag.alert = "alert-info";
                    }
                }
            }

            return View();
        }

        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }

        public ActionResult MyProfile()
        {
            ViewBag.LocationID = new SelectList(db.Locations, "LocationID", "LocationName");
            var userExist = db.Users.Find(CurrentUser.UserID);
            return View(userExist);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult MyProfile([Bind(Include = "FullName,Email,Mobile,UserPassword,FavouriteLocationIDs,Notes")] User user, HttpPostedFileBase fuPersonalImage)
        {
            var userExist = db.Users.Where(x =>x.UserID!=CurrentUser.UserID && (x.Email == user.Email || x.Mobile == user.Mobile)).FirstOrDefault();
            if (userExist != null)
            {
                ViewBag.Msg = "بيانات البريد الالكترونى أو الموبايل مسجلة من قبل ، أرجو مراجعة البيانات ";
                return View(user);
            }

            var rowExist = db.Users.Find(CurrentUser.UserID);
            if (rowExist != null)
            {
                //rowExist.FullName = user.FullName;
                if (!rowExist.IsConfirmed)
                    rowExist.Email = user.Email;
                rowExist.Mobile = user.Mobile;
                //userExist.UserPassword = user.UserPassword;
                rowExist.FavouriteLocationIDs = user.FavouriteLocationIDs;
                rowExist.Notes = user.Notes;
                if (fuPersonalImage != null)
                {
                    var FileName = fuPersonalImage.FileName;
                    var FullPath = Request.MapPath("~/Uploads/PersonalImages/" + FileName);
                    fuPersonalImage.SaveAs(FullPath);
                    rowExist.ProfileImgPath = FileName;
                }
                db.SaveChanges();
                ViewBag.SuccessMsg = "تم حفظ البيانات بنجاح";
                return View(rowExist);
            }
            
            return RedirectToAction("Login", "Home");
        }

        public ActionResult ChangePassword()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword([Bind(Include = "OldPassword,NewPassword,ConfirmPassword")] ChangePassModel changePass)
        {
            if (string.IsNullOrEmpty(changePass.ConfirmPassword) || string.IsNullOrEmpty(changePass.NewPassword) || string.IsNullOrEmpty(changePass.OldPassword))
            {
                ViewBag.Msg = "أرجو ملىء البيانات اولا";
                return View(changePass);
            }
            if(!changePass.ConfirmPassword.Equals(changePass.NewPassword))
            {
                ViewBag.Msg = "كلمة المرور الجديدة وتأكيدها غير متطابقان";
                return View(changePass);
            }
            var rowExist = db.Users.Find(CurrentUser.UserID);
            if (rowExist != null)
            {
                if(!rowExist.Provider.Equals("LinkedBroker",StringComparison.OrdinalIgnoreCase))
                {
                    ViewBag.Msg = "لا يمكن تغيير كلمة المرور لمستخدم مسجل عبر مواقع التواصل الاجتماعى";
                    return View(changePass);
                }
                var encOldPass = Encrypt.EncryptString(changePass.OldPassword);
                if (!encOldPass.Equals(rowExist.UserPassword))
                {
                    ViewBag.Msg = "كلمة المرور القديمة خاطئة أرجو المحاولة مرة أخرى";
                    return View(changePass);
                }
                rowExist.UserPassword = Encrypt.EncryptString(changePass.NewPassword);
                db.SaveChanges();
                ViewBag.SuccessMsg = "تم حفظ البيانات بنجاح";
                return View(changePass);
            }

            return View(changePass);
        }

        // GET: Users/Create
        //public ActionResult Create()
        //{
        //    InitPage("Create");
        //    ViewBag.CompanyID = new SelectList(db.Companies.Where(x => x.ByUserID == 1 && x.IsDeleted == false && x.IsActive == true), "CompanyID", "CompanyName");
        //    return View();
        //}

        //// POST: Users/Create
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Create([Bind(Include = "CompanyID,FullName,Email,Mobile,UserPassword,FavouriteLocationIDs,ProfileImgPath")] User user)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        user.EntryDate = DateTime.Now;
        //        user.IsActive = true;
        //        user.IsConfirmed = true;
        //        user.IsDeleted = false;
        //        user.ByUserID = 1;
        //        db.Users.Add(user);
        //        db.SaveChanges();
        //        var CompanyMemberPermissions = db.Permission_PermissionGroup.Where(x => x.PermissionGroupID == 2).ToList();
        //        foreach (var Item in CompanyMemberPermissions)
        //        {
        //            var UserPermission = new User_UserPermission();
        //            UserPermission.UserID = user.UserID;
        //            UserPermission.UserPermissionID = Item.UserPermissionID;
        //            UserPermission.ByUserID = 1;
        //            db.User_UserPermission.Add(UserPermission);
        //        }
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }

        //    ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", user.CompanyID);
        //    return View(user);
        //}

        //// GET: Users/Edit/5
        //public ActionResult Edit(long? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    User user = db.Users.Find(id);
        //    if (user == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", user.CompanyID);
        //    return View(user);
        //}

        //// POST: Users/Edit/5
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Edit([Bind(Include = "UserID,FullName,Email,Mobile")] User user)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        var row = db.Users.Find(user.UserID);
        //        row.FullName = user.FullName;
        //        row.Email = user.Email;
        //        row.Mobile = user.Mobile;
        //        db.SaveChanges();
        //        return RedirectToAction("Index");
        //    }
        //    ViewBag.CompanyID = new SelectList(db.Companies, "CompanyID", "CompanyName", user.CompanyID);
        //    return View(user);
        //}

        //// POST: Users/Delete/5
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Delete(long id)
        //{
        //    User user = db.Users.Find(id);
        //    user.IsDeleted = true;
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
