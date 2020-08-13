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
    public class PropertyRequestsController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        // GET: PropertyRequests
        public ActionResult Index()
        {
            var propertyRequests = db.PropertyRequests.Where(x=>!x.IsDeleted && x.ByUserID == CurrentUser.UserID).Include(p => p.Location).Include(p => p.OwnerShipType).Include(p => p.PropertyFloorType).Include(p => p.PropertyPurpose).Include(p => p.PropertyType);
            return View(propertyRequests.ToList());
        }

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;

            ViewBag.Locations = new SelectList(db.Locations.Where(x=>x.IsActive&&x.LocationID>4), "LocationID", "LocationName");
            ViewBag.OwnerShipType = new SelectList(db.OwnerShipTypes, "OwnerShipTypeID", "OwnerShipTitle");
            ViewBag.PropertyFloorType = new SelectList(db.PropertyFloorTypes, "PropertyFloorTypeID", "FloorTypeTitle");
            ViewBag.PropertyPurpose = new SelectList(db.PropertyPurposes, "PropertyPurposeID", "PropPurposeTitle");
            ViewBag.PropertyType = new SelectList(db.PropertyTypes, "PropertyTypeID", "PropTypeTitle");
        }


        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }
        // GET: PropertyRequests/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("PropertyRequest", new PropertyRequest());
        }

        // POST: PropertyRequests/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "LocationIDs,AddressDetails,MinPrice,MaxPrice,CanInstallment,NoOfYears,PropertyFloorTypeID,MinArea,MaxArea,OwnerShipTypeID,PropertyTypeID,PropertyPurposeID,Title,Comments,CityID,GovID,IsActive")] PropertyRequest propertyRequest)
        {
            if (ModelState.IsValid)
            {
                propertyRequest.IsActive = true;
                propertyRequest.EntryDate = DateTime.Now;
                propertyRequest.ByUserID = CurrentUser.UserID;
                if(propertyRequest.LocationIDs.HasValue && propertyRequest.LocationIDs.Value==0)
                    propertyRequest.LocationIDs = null;
                db.PropertyRequests.Add(propertyRequest);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("PropertyRequest",propertyRequest);
        }

        // GET: PropertyRequests/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PropertyRequest propertyRequest = db.PropertyRequests.Find(id);
            if (propertyRequest == null)
            {
                return HttpNotFound();
            }
            InitPage("Edit");
            ViewBag.GovID = propertyRequest.GovID;
            ViewBag.CityID = propertyRequest.CityID;
            ViewBag.LocationIDs = propertyRequest.LocationIDs;
            return View("PropertyRequest", propertyRequest);
        }

        // POST: PropertyRequests/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "RequestID,LocationIDs,AddressDetails,MinPrice,MaxPrice,CanInstallment,NoOfYears,PropertyFloorTypeID,MinArea,MaxArea,OwnerShipTypeID,PropertyTypeID,PropertyPurposeID,Comments,Title,CityID,GovID,IsActive")] PropertyRequest propertyRequest)
        {
            if (ModelState.IsValid)
            {
                propertyRequest.IsActive = true;
                propertyRequest.EntryDate = DateTime.Now;
                propertyRequest.ByUserID = CurrentUser.UserID;
                if (propertyRequest.LocationIDs.HasValue && propertyRequest.LocationIDs.Value == 0)
                    propertyRequest.LocationIDs = null;
                db.Entry(propertyRequest).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Edit");
            return View("PropertyRequest", propertyRequest);
        }

        // GET: PropertyRequests/Delete/5
        public ActionResult Delete(long? id)
        {

            PropertyRequest propertyRequest = db.PropertyRequests.Find(id);
            propertyRequest.IsDeleted = true;
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // POST: PropertyRequests/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            PropertyRequest propertyRequest = db.PropertyRequests.Find(id);
            db.PropertyRequests.Remove(propertyRequest);
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
