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
    public class OwnerShipTypesController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;
            //ViewBag.Cities = new SelectList(db.Cities, "CityID", "CityName");
        }

        // GET: OwnerShipTypes
        public ActionResult Index()
        {
            return View(db.OwnerShipTypes.ToList());
        }

        // GET: OwnerShipTypes/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("OwnerShipType", new OwnerShipType());
        }

        // POST: OwnerShipTypes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "OwnerShipTitle,IsActive")] OwnerShipType ownerShipType)
        {
            if (ModelState.IsValid)
            {
                ownerShipType.EntryDate = DateTime.Now;
                db.OwnerShipTypes.Add(ownerShipType);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("OwnerShipType", ownerShipType);
        }

        // GET: OwnerShipTypes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            OwnerShipType ownerShipType = db.OwnerShipTypes.Find(id);
            if (ownerShipType == null)
            {
                return HttpNotFound();
            }
            InitPage("Edit");
            return View("OwnerShipType", ownerShipType);
        }

        // POST: OwnerShipTypes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "OwnerShipTypeID,OwnerShipTitle,IsActive")] OwnerShipType ownerShipType)
        {
            if (ModelState.IsValid)
            {
                var rowExist = db.OwnerShipTypes.Find(ownerShipType.OwnerShipTypeID);
                if(rowExist!=null)
                {
                    rowExist.IsActive = ownerShipType.IsActive;
                    rowExist.OwnerShipTitle = ownerShipType.OwnerShipTitle;
                    db.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            InitPage("Edit");
            return View("OwnerShipType", ownerShipType);
        }

        // GET: OwnerShipTypes/Delete/5
        public ActionResult Delete(int? id)
        {
            var ownerShipType = db.OwnerShipTypes.Find(id);
            if(ownerShipType!=null)
            {
                ownerShipType.IsDeleted = true;
                db.SaveChanges();
            }
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
