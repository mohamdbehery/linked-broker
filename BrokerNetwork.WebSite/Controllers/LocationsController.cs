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
    public class LocationsController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        // GET: Locations
        public ActionResult Index()
        {
            return View(db.Locations.Where(x=> !x.IsDeleted).ToList());
        }
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
        }

        // GET: Locations/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("Location", new Location());
        }

        // POST: Locations/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "LocationName,IsActive,ParentID")] Location location)
        {
            if (ModelState.IsValid)
            {
                location.IsActive = true;
                location.ByUserID = CurrentUser.UserID;
                location.EntryDate = DateTime.Now;
                location.ParentID = location.ParentID;
                db.Locations.Add(location);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("Location",location);
        }

        // GET: Locations/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Location location = db.Locations.Find(id);
            if (location == null)
            {
                return HttpNotFound();
            }
            InitPage("Edit");
            return View("Location",location);
        }

        // POST: Locations/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "LocationID,LocationName,IsActive")] Location location)
        {
            if (ModelState.IsValid)
            {
                Location existRow = db.Locations.Find(location.LocationID);
                if(existRow!=null)
                {
                    existRow.LocationName = location.LocationName;
                    //existRow.IsActive = location.IsActive;
                    db.SaveChanges();
                }
                return RedirectToAction("Index");
            }

            InitPage("Edit");
            return View("Location", location);
        }

        // GET: Locations/Delete/5
        public ActionResult Delete(int? id)
        {
            Location location = db.Locations.Find(id);
            location.IsDeleted = true;
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
