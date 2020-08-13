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
using BrokerNetwork.WebSite.Models;

namespace BrokerNetwork.WebSite.Controllers
{
    public class CompaniesController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;
            ViewBag.CompayTypes = new SelectList(db.CompanyTypes, "CompanyTypeID", "CompanyTypeTitle");
        }

        // GET: Companies
        public ActionResult Index()
        {
            return View(db.Companies.Where(x => x.IsDeleted == false && x.ByUserID == CurrentUser.UserID).ToList());
        }
        [Authorize(Roles ="SuperAdmin,Admin")]
        public ActionResult ApproveCompanies()
        {
            return View(db.Companies.Where(x => !x.IsDeleted).Include("CompanyType").OrderByDescending(x=>x.CompanyID).ToList());
        }
        [Authorize(Roles = "SuperAdmin,Admin")]
        public ActionResult ApproveCompany(int companyID)
        {
            var fileExist = db.Companies.Where(x => x.CompanyID == companyID).FirstOrDefault();
            if (fileExist != null)
            {
                fileExist.IsActive = true;
                db.SaveChanges();
            }
            return RedirectToAction("ApproveCompanies");
        }
        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }

        // GET: Companies/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("Company");
        }

        // POST: Companies/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CompanyName,CompanyDesc,Contacts,ContactsForBrokers,CompanyTypeID")] Company company,HttpPostedFileBase fupCompanyImg)
        {
            if (ModelState.IsValid)
            {
                company.ByUserID = CurrentUser.UserID;
                company.CompanyVerificationTypeID = 2; // free
                company.EntryDate = DateTime.Now;
                company.IsActive = false;
                company.IsDeleted = false;
                if (fupCompanyImg != null)
                {
                    var FileName = fupCompanyImg.FileName;
                    var FullPath = Request.MapPath("~/Uploads/CompanyProfile/" + FileName);
                    fupCompanyImg.SaveAs(FullPath);
                    company.ImgPath = FileName;
                }
                db.Companies.Add(company);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("Company",company);
        }

        // GET: Companies/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Company company = db.Companies.Find(id);
            if (company == null)
            {
                return HttpNotFound();
            }
            InitPage("Edit");
            return View("Company",company);
        }

        // POST: Companies/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CompanyID,CompanyName,CompanyDesc,Contacts,ContactsForBrokers,CompanyTypeID")] Company company, HttpPostedFileBase fupCompanyImg)
        {
            if (ModelState.IsValid)
            {
                var row = db.Companies.Find(company.CompanyID);
                row.CompanyName = company.CompanyName;
                row.CompanyDesc = company.CompanyDesc;
                row.Contacts = company.Contacts;
                row.ContactsForBrokers = company.ContactsForBrokers;
                row.CompanyTypeID = company.CompanyTypeID;
                if (fupCompanyImg != null)
                {
                    var FileName = string.Format("{0}{1}", Guid.NewGuid(), Path.GetExtension(fupCompanyImg.FileName));
                    var FullPath = Request.MapPath("~/Uploads/CompanyProfile/" + FileName);
                    fupCompanyImg.SaveAs(FullPath);
                    row.ImgPath = FileName;
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Edit");
            return View("Company",company);
        }


        // GET: Companies/Edit/5
        public ActionResult CompanyBroker(int? id)
        {
            var model = new CompanyBrokersModel();
            if (!id.HasValue)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Company company = db.Companies.Find(id);
            if (company == null || company.ByUserID!=CurrentUser.UserID)
            {
                return HttpNotFound();
            }
            else
            {
                model.CompanyID = id.Value;
                model.Brokers = company.CompanyBrokers;
                return View(model);
            }
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CompanyBroker(CompanyBrokersModel model)
        {
            Company company = db.Companies.Find(model.CompanyID);
            if (company == null || company.ByUserID != CurrentUser.UserID)
            {
                return HttpNotFound();
            }
            else
            {
                model.CompanyID = model.CompanyID;
                model.SearchBroker = model.SearchBroker.Trim();
                var existBroker = db.Users.Where(x => x.Email == model.SearchBroker).FirstOrDefault();
                if(existBroker!=null)
                {
                    var existBrokerInCompany = company.CompanyBrokers.Where(x => x.UserID == existBroker.UserID).FirstOrDefault();
                    if (existBrokerInCompany != null)
                    {
                        model.SearchStatus = false;
                        model.Msg = "هذا الوسيط مضاف من قبل";
                    }
                    else
                    {
                        var newBrokerCompany = new CompanyBroker();
                        newBrokerCompany.UserID = existBroker.UserID;
                        newBrokerCompany.CompanyID = company.CompanyID;
                        db.CompanyBrokers.Add(newBrokerCompany);
                        db.SaveChanges();
                        model.Msg = "تم إضافة الوسيط بنجاح";
                        model.SearchBroker = string.Empty;
                    }
                    }
                else
                {
                    model.SearchStatus = false;
                    model.Msg = "هذا الوسيط غير موجود";
                }
                model.Brokers = db.CompanyBrokers.Where(x=>x.CompanyID==model.CompanyID).ToList();
                return View(model);
            }
        }
        // GET: Companies/Delete/5
        public ActionResult Delete(int? id)
        {
            Company company = db.Companies.Find(id);
            company.IsDeleted = true;
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        [HttpGet]
        public ActionResult DeleteCompanyBroker(int? id)
        {
            var broker = db.CompanyBrokers.Find(id);
            if (broker != null)
            {
                db.CompanyBrokers.Remove(broker);
                db.SaveChanges();
            }
            return RedirectToAction("CompanyBroker",new { id= broker.CompanyID});
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
