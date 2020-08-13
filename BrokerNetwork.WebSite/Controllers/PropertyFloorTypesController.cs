using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BrokerNetwork.Models;

namespace BrokerNetwork.WebSite.Controllers
{
    public class PropertyFloorTypesController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;
            //ViewBag.Cities = new SelectList(db.Cities, "CityID", "CityName");
        }
        // GET: PropertyFloorTypes
        public ActionResult Index()
        {
            return View(db.PropertyFloorTypes.Where(x => x.IsDeleted == false).ToList());
        }
        
        // GET: PropertyFloorTypes/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("PropertyFloorType");
        }

        // POST: PropertyFloorTypes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "FloorTypeTitle,IsActive")] PropertyFloorType propertyFloorType)
        {
            if (ModelState.IsValid)
            {
                propertyFloorType.IsDeleted = false;
                propertyFloorType.EntryDate = DateTime.Now;
                propertyFloorType.ByUserID = 1;
                db.PropertyFloorTypes.Add(propertyFloorType);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("PropertyFloorType", propertyFloorType);
        }

        // GET: PropertyFloorTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PropertyFloorType propertyFloorType = db.PropertyFloorTypes.Find(id);
            if (propertyFloorType == null)
            {
                return HttpNotFound();
            }
            InitPage("Edit");
            return View("PropertyFloorType", propertyFloorType);
        }

        // POST: PropertyFloorTypes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PropertyFloorTypeID,FloorTypeTitle,IsActive")] PropertyFloorType propertyFloorType)
        {
            if (ModelState.IsValid)
            {
                var row = db.PropertyFloorTypes.Find(propertyFloorType.PropertyFloorTypeID);
                if (row != null)
                {
                    row.FloorTypeTitle = propertyFloorType.FloorTypeTitle;
                    row.IsActive = propertyFloorType.IsActive;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }

            InitPage("Edit");
            return View("PropertyFloorType", propertyFloorType);
        }

        // GET: PropertyFloorTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            PropertyFloorType propertyFloorType = db.PropertyFloorTypes.Find(id);
            propertyFloorType.IsDeleted = true;
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
