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
using BrokerNetwork.Models.Business;
using BrokerNetwork.Models.Model;

namespace BrokerNetwork.WebSite.Controllers
{
    public class MyPropertiesController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;

            ViewBag.Locations = new SelectList(db.Locations.Where(x => x.IsActive && !x.IsDeleted && x.ParentID != null && x.LocationID > 4), "LocationID", "LocationName");
            ViewBag.OwnerShipTypes = new SelectList(db.OwnerShipTypes, "OwnerShipTypeID", "OwnerShipTitle");
            var proj = db.Projects.Where(x => x.ByUserID == CurrentUser.UserID).Select(x => new { x.ProjectID, x.ProjectName }).ToList();
            proj.Insert(0, new { ProjectID = 0, ProjectName = "اختر" });
            ViewBag.Projects = new SelectList(proj, "ProjectID", "ProjectName");
            ViewBag.PropertyFloorTypes = new SelectList(db.PropertyFloorTypes, "PropertyFloorTypeID", "FloorTypeTitle");
            ViewBag.PropertyTypes = new SelectList(db.PropertyTypes, "PropertyTypeID", "PropTypeTitle");
            ViewBag.PropertyPurposes = new SelectList(db.PropertyPurposes, "PropertyPurposeID", "PropPurposeTitle");
            ViewBag.Shared = new SelectList(db.Shareds, "ShareID", "ShareTitle");
            //
            var commList = new List<SelectListItem>();
            for (double i = 0; i <= 5; i += .5)
            {
                var comm = new SelectListItem();
                comm.Text = "%" + i;
                comm.Value = i.ToString();
                commList.Add(comm);
            }
            ViewBag.Commissions = new SelectList(commList, "Value", "Text");

            var commTypes = new List<SelectListItem>();
            var comType = new SelectListItem();
            comType.Text = "عمولة سوف تقوم بدفعها للطرف الاخر";
            comType.Value = "1";
            commTypes.Add(comType);

            comType = new SelectListItem();
            comType.Text = "عمولة مطلوبة من الطرف الاخر";
            comType.Value = "2";
            commTypes.Add(comType);

            ViewBag.CommissionTypes = new SelectList(commTypes, "Value", "Text");
        }
        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }
        // GET: Properties
        public ActionResult Index(int? id)
        {
            var filter = new FilterList<PropertyShortDisplay>();
            filter.projectID = id;
            var rows = new BLayer().GetAllPropertiesLanding(filter, PropertiesDisplayType.CurrentUser);
            //var properties = db.Properties.Where(x=>x.ByUserID==CurrentUser.UserID).Include(p => p.Location).Include(p => p.OwnerShipType).Include(p => p.Project).Include(p => p.PropertyFloorType).Include(p => p.PropertyType).Include(p => p.PropertyPurpose);
            return View(rows);
        }

        // GET: Properties/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("Property", new FullProperty());
        }

        // POST: Properties/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CustomerID,LocationID,AddressDetails,ProjectID,IsUnit,Price,CanInstallment,NoOfYears,DownPayment,FloorNum,PropertyFloorTypeID,NoOfProperties,Area,OwnerShipTypeID,PropertyTypeID,PropertyPurposeID,HasElevator,HasGarage,NumberOfRooms,NumberOfBathrooms,ReadyDate,SharedID,Comments,AllowVisitors,Commission,Title,IsActive,CommissionType")] FullProperty property, HttpPostedFileBase[] files)
        {
            var modelErrors = ModelState.Where(x => x.Value.Errors.Count > 0).ToList();
            if (ModelState.IsValid)
            {
                var prop = new Property();
                prop.AddressDetails = property.AddressDetails;
                prop.AllowVisitors = property.AllowVisitors;
                prop.Area = property.Area;
                prop.CanInstallment = property.CanInstallment;
                prop.Comments = property.Comments;
                prop.Commission = property.Commission;
                prop.CustomerID = property.CustomerID;
                prop.DownPayment = property.DownPayment;
                prop.FloorNum = property.FloorNum;
                prop.HasElevator = property.HasElevator;
                prop.HasGarage = property.HasGarage;
                prop.IsDeleted = false;
                prop.IsUnit = property.IsUnit;
                prop.LocationID = property.LocationID;
                prop.NoOfProperties = property.NoOfProperties;
                prop.NoOfYears = property.NoOfYears;
                prop.NumberOfBathrooms = property.NumberOfBathrooms;
                prop.NumberOfRooms = property.NumberOfRooms;
                prop.OwnerShipTypeID = property.OwnerShipTypeID;
                prop.Price = property.Price;
                prop.ProjectID = property.ProjectID == 0 ? null : property.ProjectID;
                prop.PropertyFloorTypeID = property.PropertyFloorTypeID;
                prop.PropertyPurposeID = property.PropertyPurposeID;
                prop.PropertyTypeID = property.PropertyTypeID;
                prop.ReadyDate = property.ReadyDate;
                prop.SharedID = property.SharedID;
                prop.Title = property.Title;
                prop.CommissionType = property.CommissionType;

                prop.EntryDate = DateTime.Now;
                prop.LastUpdated = DateTime.Now;
                prop.ByUserID = CurrentUser.UserID;
                prop.IsActive = true;
                db.Properties.Add(prop);
                db.SaveChanges();
                AddImages(files, prop.PropertyID);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("Property", property);
        }

        // GET: Properties/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Property property = db.Properties.Find(id);
            if (property == null)
            {
                return HttpNotFound();
            }

            var prop = new FullProperty();
            prop.PropertyID = property.PropertyID;
            prop.AddressDetails = property.AddressDetails;
            prop.AllowVisitors = property.AllowVisitors;
            prop.Area = property.Area;
            prop.CanInstallment = property.CanInstallment;
            prop.Comments = property.Comments;
            prop.Commission = property.Commission;
            prop.CommissionType = property.CommissionType;
            prop.CustomerID = property.CustomerID;
            prop.DownPayment = property.DownPayment;
            prop.FloorNum = property.FloorNum;
            prop.HasElevator = property.HasElevator;
            prop.HasGarage = property.HasGarage;
            prop.IsUnit = property.IsUnit;
            prop.LocationID = property.LocationID;
            prop.NoOfProperties = property.NoOfProperties;
            prop.NoOfYears = property.NoOfYears;
            prop.NumberOfBathrooms = property.NumberOfBathrooms;
            prop.NumberOfRooms = property.NumberOfRooms;
            prop.OwnerShipTypeID = property.OwnerShipTypeID;
            prop.Price = property.Price;
            prop.ProjectID = property.ProjectID;
            prop.PropertyFloorTypeID = property.PropertyFloorTypeID;
            prop.PropertyPurposeID = property.PropertyPurposeID;
            prop.PropertyTypeID = property.PropertyTypeID;
            prop.ReadyDate = property.ReadyDate;
            prop.SharedID = property.SharedID;
            prop.Title = property.Title;
            prop.IsActive = true;

            ViewBag.LocationID = property.LocationID;
            ViewBag.Images = db.Files.Where(x => x.ParentID == id && x.ParentType == "Properties").ToList();
            InitPage("Edit");
            return View("Property", prop);
        }

        // POST: Properties/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PropertyID,CustomerID,LocationID,AddressDetails,ProjectID,IsUnit,Price,CanInstallment,NoOfYears,DownPayment,FloorNum,PropertyFloorTypeID,NoOfProperties,Area,OwnerShipTypeID,PropertyTypeID,PropertyPurposeID,HasElevator,HasGarage,NumberOfRooms,NumberOfBathrooms,ReadyDate,SharedID,Comments,Commission,AllowVisitors,Title,IsActive,CommissionType")] Property property, HttpPostedFileBase[] files)
        {
            if (ModelState.IsValid)
            {
                property.ProjectID = property.ProjectID > 0 ? property.ProjectID : null;
                property.IsActive = true;
                property.LastUpdated = DateTime.Now;
                property.EntryDate = DateTime.Now;
                property.ByUserID = CurrentUser.UserID;
                db.Entry(property).State = EntityState.Modified;
                AddImages(files, property.PropertyID);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Edit");
            return View("Property", property);
        }

        // GET: Properties/Delete/5
        public ActionResult Delete(long? id)
        {
            Property property = db.Properties.Find(id);
            property.IsDeleted = true;
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult DeleteImage(long subID, int imgID)
        {
            var fileExist = db.Files.Where(x => x.ParentType == "Properties" && x.ParentID == subID && x.FileID == imgID).FirstOrDefault();
            if (fileExist != null)
            {
                var fileName = fileExist.FileName;
                db.Files.Remove(fileExist);
                db.SaveChanges();
                var imgPath = Request.MapPath("~/Upload/Properties/" + fileName);
                if (System.IO.File.Exists(imgPath))
                    System.IO.File.Delete(imgPath);
            }
            return RedirectToAction("Edit", new { id = subID });
        }
        private void AddImages(HttpPostedFileBase[] images, long parentID)
        {
            if (images != null && images.Length > 0 && images[0] != null)
            {
                foreach (var f in images)
                {
                    var FileName = string.Format("{0}{1}", Guid.NewGuid(), Path.GetExtension(f.FileName));
                    var FullPath = Request.MapPath("~/Uploads/Properties/" + FileName);
                    f.SaveAs(FullPath);
                    var file = new BrokerNetwork.Models.File();
                    file.CreatedDate = DateTime.Now;
                    file.IsActive = true;
                    file.IsDeleted = false;
                    file.LastUpdated = DateTime.Now;
                    file.OrginalFileName = FileName;
                    file.FileName = FileName;
                    file.ParentID = parentID;
                    file.ParentType = "Properties";
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
