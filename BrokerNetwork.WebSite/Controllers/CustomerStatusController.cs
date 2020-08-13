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
    public class CustomerStatusController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        // GET: CustomerStatus
        public ActionResult Index()
        {
            return View(db.CustomerStatus.ToList());
        }

        // GET: CustomerStatus/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CustomerStatu customerStatu = db.CustomerStatus.Find(id);
            if (customerStatu == null)
            {
                return HttpNotFound();
            }
            return View(customerStatu);
        }

        // GET: CustomerStatus/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: CustomerStatus/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CustomerStatusID,CustomerStatusTitle,ByUserID,EntryDate,IsActive,IsDeleted")] CustomerStatu customerStatu)
        {
            if (ModelState.IsValid)
            {
                db.CustomerStatus.Add(customerStatu);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(customerStatu);
        }

        // GET: CustomerStatus/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CustomerStatu customerStatu = db.CustomerStatus.Find(id);
            if (customerStatu == null)
            {
                return HttpNotFound();
            }
            return View(customerStatu);
        }

        // POST: CustomerStatus/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CustomerStatusID,CustomerStatusTitle,ByUserID,EntryDate,IsActive,IsDeleted")] CustomerStatu customerStatu)
        {
            if (ModelState.IsValid)
            {
                db.Entry(customerStatu).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(customerStatu);
        }

        // GET: CustomerStatus/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CustomerStatu customerStatu = db.CustomerStatus.Find(id);
            if (customerStatu == null)
            {
                return HttpNotFound();
            }
            return View(customerStatu);
        }

        // POST: CustomerStatus/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            CustomerStatu customerStatu = db.CustomerStatus.Find(id);
            db.CustomerStatus.Remove(customerStatu);
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
