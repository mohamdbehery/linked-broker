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
    public class CustomersController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;
            ViewBag.CustomerStatusID = new SelectList(db.CustomerStatus, "CustomerStatusID", "CustomerStatusTitle");
            //ViewBag.ByUserID = new SelectList(db.Users, "UserID", "FullName");
        }
        // GET: Customers
        public ActionResult Index()
        {
            //var customers = db.Customers.Include(c => c.CustomerStatu).Include(c => c.User);
            //return View(customers.ToList());
            return View();
        }

        // GET: Customers/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("Customer");
        }

        // POST: Customers/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CustomerStatusID,CustomerName,Notes,Comments,IsActive")] Customer customer)
        {
            customer.ByUserID = CurrentUser.UserID;
            customer.CreatedDate = DateTime.Now;
            customer.EntryDate = DateTime.Now;
            if (ModelState.IsValid)
            {
                db.Customers.Add(customer);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            InitPage("Create");
            return View("Customer",customer);
        }

        // GET: Customers/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Customer customer = db.Customers.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            InitPage("Edit");
            return View("Customer", customer);
        }

        // POST: Customers/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CustomerID,CustomerStatusID,CustomerName,Notes,Comments,IsActive")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                var rowExist = db.Customers.Find(customer.CustomerID);
                if(rowExist!=null)
                {
                    rowExist.CustomerName = customer.CustomerName;
                    rowExist.CustomerStatusID = customer.CustomerStatusID;
                    rowExist.Notes = customer.Notes;
                    rowExist.IsActive = customer.IsActive;
                    rowExist.Comments = customer.Comments;
                    db.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            InitPage("Edit");
            return View("Customer", customer);
        }

        //// GET: Customers/Delete/5
        //public ActionResult Delete(long? id)
        //{
        //    var customer = db.Customers.Find(id);
        //    db.Customers.Remove(customer);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

        // POST: Customers/Delete/5
        //[HttpPost, ActionName("Delete")]
        ////[ValidateAntiForgeryToken]
        //public ActionResult DeleteConfirmed(long id)
        //{
        //    Customer customer = db.Customers.Find(id);
        //    customer.IsDeleted = true;
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
        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }
    }
}
