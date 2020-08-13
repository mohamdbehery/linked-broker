using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Web;
using System.Web.Mvc;
using BrokerNetwork.Models;
using BrokerNetwork.Models.Model;

namespace BrokerNetwork.WebSite.Controllers
{
    public class VerficationRequestsController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        //GET: VerficationRequests
        public ActionResult Index()
        {
            var verficationRequests = db.VerficationRequests.Where(x=>x.UserID==CurrentUser.UserID).Include(v => v.VerficationStatu);
            return View(verficationRequests.ToList());
        }
        [Authorize(Roles = "SuperAdmin,Admin")]
        public ActionResult AdminVerificationCompanies()
        {
            var verficationRequests = db.VerficationRequests.Where(x => x.VerfiedStatusID!=2).Include(v => v.VerficationStatu);
            return View(verficationRequests.ToList());
        }
        [Authorize(Roles = "SuperAdmin,Admin")]
        public ActionResult AdminVerifyCompany(int? id)
        {
            var requestExist = db.VerficationRequests.Find(id);
            if(requestExist==null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ViewBag.VerificationStatusTypes = new SelectList(db.VerficationStatus, "VerfiedStatusID", "VerfiedStatusTitle");
            return View(requestExist);
        }
        [Authorize(Roles = "SuperAdmin,Admin")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AdminVerifyCompany([Bind(Include = "VerficationID,AdminMessage,VerfiedStatusID")] VerficationRequest verficationRequest)
        {
            var requestExist = db.VerficationRequests.Find(verficationRequest.VerficationID);
            if (requestExist == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            requestExist.VerfiedStatusID = verficationRequest.VerfiedStatusID;
            requestExist.AdminMessage = verficationRequest.AdminMessage;
            if(requestExist.VerfiedStatusID == 2)
            {
                var companyBrokers = db.CompanyBrokers.Where(x => x.CompanyID == requestExist.CompanyID);
                foreach(var row in companyBrokers)
                    row.User.IsVerfied = true;
            }
            db.SaveChanges();
            return RedirectToAction("AdminVerificationCompanies");
        }
        // GET: VerficationRequests/Create
        public ActionResult VerficationRequest(int? id)
        {
            //if(!id.HasValue)
            //{
            //    return 
            //}
            var companies = db.Companies.Where(x => x.IsActive && !x.IsDeleted && x.ByUserID == CurrentUser.UserID);
            var existCompQuery = db.VerficationRequests.AsQueryable();
            if(id.HasValue)
            {
                existCompQuery = existCompQuery.Where(x => x.VerficationID != id.Value);
            }
            var existsCompanies = existCompQuery.Select(x => x.CompanyID).ToList();
            companies = companies.Where(x => !existsCompanies.Contains(x.CompanyID));
            ViewBag.Companies = new SelectList(companies, "CompanyID", "CompanyName");
            var existUser = db.Users.Find(CurrentUser.UserID);
            if (existUser != null)
            {
                var requestExist = db.VerficationRequests.Find(id);
                if (requestExist != null)
                {
                    ViewBag.Images = db.Files.Where(x => x.ParentType == "Verfication" && x.ParentID == CurrentUser.UserID).ToList();
                    return View(requestExist);
                }
            }
            return View(new VerficationRequest());
        }
        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }
        // POST: VerficationRequests/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult VerficationRequest([Bind(Include = "VerficationID,RequestContent,CompanyID")] VerficationRequest verficationRequest, HttpPostedFileBase[] files)
        {
            if (ModelState.IsValid && verficationRequest.CompanyID >0 && !string.IsNullOrEmpty(verficationRequest.RequestContent))
            {
                var existUser = db.Users.Find(CurrentUser.UserID);
                if (existUser != null)
                {
                    var requestExist = db.VerficationRequests.Find(verficationRequest.VerficationID);
                    if (requestExist == null)
                    {
                        verficationRequest.EntryDate = DateTime.Now;
                        verficationRequest.UserID = CurrentUser.UserID;
                        existUser.IsVerfied = false;
                        verficationRequest.VerfiedStatusID = 1;
                        verficationRequest.LastUpdated = DateTime.Now;
                        db.VerficationRequests.Add(verficationRequest);
                    }
                    else
                    {
                        existUser.IsVerfied = false;
                        requestExist.CompanyID = verficationRequest.CompanyID;
                        requestExist.VerfiedStatusID = 1;
                        requestExist.LastUpdated = DateTime.Now;
                        requestExist.RequestContent = verficationRequest.RequestContent;
                    }
                    db.SaveChanges();
                    AddImages(files, CurrentUser.UserID);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            var companies = db.Companies.Where(x => x.IsActive && !x.IsDeleted && x.ByUserID == CurrentUser.UserID);
            var existCompQuery = db.VerficationRequests.AsQueryable();
            if (verficationRequest.VerficationID>0)
            {
                existCompQuery = existCompQuery.Where(x => x.VerficationID != verficationRequest.VerficationID);
            }
            var existsCompanies = existCompQuery.Select(x => x.CompanyID).ToList();
            companies = companies.Where(x => !existsCompanies.Contains(x.CompanyID));
            ViewBag.Companies = new SelectList(companies, "CompanyID", "CompanyName");
            return View(verficationRequest);
        }
        public ActionResult DeleteImage(long subID, int imgID)
        {
            var fileExist = db.Files.Where(x => x.ParentType == "Verfication" && x.ParentID == subID && x.FileID == imgID).FirstOrDefault();
            if (fileExist != null)
            {
                var fileName = fileExist.FileName;
                db.Files.Remove(fileExist);
                db.SaveChanges();
                var imgPath = Request.MapPath("~/Upload/Verfication/" + fileName);
                if (System.IO.File.Exists(imgPath))
                    System.IO.File.Delete(imgPath);
            }
            return RedirectToAction("VerficationRequest");
        }
        private void AddImages(HttpPostedFileBase[] images, long parentID)
        {
            if (images != null && images.Length > 0 && images[0] != null)
            {
                foreach (var f in images)
                {
                    var FileName = string.Format("{0}{1}", Guid.NewGuid(), Path.GetExtension(f.FileName));
                    var FullPath = Request.MapPath("~/Uploads/Verfication/" + FileName);
                    f.SaveAs(FullPath);
                    var file = new BrokerNetwork.Models.File();
                    file.CreatedDate = DateTime.Now;
                    file.IsActive = true;
                    file.IsDeleted = false;
                    file.LastUpdated = DateTime.Now;
                    file.OrginalFileName = FileName;
                    file.FileName = FileName;
                    file.ParentID = parentID;
                    file.ParentType = "Verfication";
                    db.Files.Add(file);
                }
            }
        }

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
