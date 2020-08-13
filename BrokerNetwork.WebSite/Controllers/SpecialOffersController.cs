using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Web;
using System.Web.Mvc;
using BrokerNetwork.Models;
using BrokerNetwork.Models.Model;

namespace BrokerNetwork.WebSite.Controllers
{
    public class SpecialOffersController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();
        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }
        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;
            //ViewBag.CompayTypes = new SelectList(db.CompanyTypes, "CompanyTypeID", "CompanyTypeTitle");
        }
        // GET: SpecialOffers
        public ActionResult Index()
        {
            return View(db.SpecialOffers.Where(x=>!x.IsDeleted).ToList());
        }
        
        // GET: SpecialOffers/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("SpecialOffer");
        }

        // POST: SpecialOffers/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "OfferTitle,OfferDesc,IsActive,SortOrder")] SpecialOffer specialOffer, HttpPostedFileBase fupOfferImg)
        {
            if (ModelState.IsValid)
            {
                specialOffer.ByUserID = CurrentUser.UserID;
                specialOffer.EntryDate = DateTime.Now;
                specialOffer.IsDeleted = false;
                if (fupOfferImg != null)
                {
                    var FileName = fupOfferImg.FileName;
                    var FullPath = Request.MapPath("~/Uploads/SpecialOffers/" + FileName);
                    fupOfferImg.SaveAs(FullPath);
                    specialOffer.ImgPath = FileName;
                }
                db.SpecialOffers.Add(specialOffer);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("SpecialOffer",specialOffer);
        }

        // GET: SpecialOffers/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SpecialOffer specialOffer = db.SpecialOffers.Find(id);
            if (specialOffer == null)
            {
                return HttpNotFound();
            }
            InitPage("Edit");
            return View("SpecialOffer", specialOffer);
        }

        // POST: SpecialOffers/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "OfferID,OfferTitle,OfferDesc,ImgPath,IsActive,SortOrder")] SpecialOffer specialOffer, HttpPostedFileBase fupOfferImg)
        {
            if (ModelState.IsValid)
            {
                var row = db.SpecialOffers.Find(specialOffer.OfferID);
                row.OfferTitle = specialOffer.OfferTitle;
                row.OfferDesc = specialOffer.OfferDesc;
                row.SortOrder = specialOffer.SortOrder;
                row.IsActive = specialOffer.IsActive;
                if (fupOfferImg!= null)
                {
                    var FileName = string.Format("{0}{1}", Guid.NewGuid(), System.IO.Path.GetExtension(fupOfferImg.FileName));
                    var FullPath = Request.MapPath("~/Uploads/SpecialOffers/" + FileName);
                    fupOfferImg.SaveAs(FullPath);
                    row.ImgPath = FileName;
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Edit");
            return View("SpecialOffer", specialOffer);
        }

        // GET: SpecialOffers/Delete/5
        public ActionResult Delete(int? id)
        {
            SpecialOffer specialOffer = db.SpecialOffers.Find(id);
            specialOffer.IsDeleted = true;
            db.SaveChanges();
            return RedirectToAction("Index");
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