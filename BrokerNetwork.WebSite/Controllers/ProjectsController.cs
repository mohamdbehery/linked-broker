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
    public class ProjectsController : Controller
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        private void InitPage(string actionName)
        {
            ViewBag.Action = actionName;
            ViewBag.Companies = new SelectList(db.Companies.Where(x => x.IsDeleted == false && x.IsActive == true && x.ByUserID == CurrentUser.UserID), "CompanyID", "CompanyName");
            //ViewBag.Country = new SelectList(db.Locations.Where(x => x.IsActive == true && x.IsDeleted == false && x.ParentID == null), "LocationID", "LocationName");
            //var CountryID = db.Locations.Where(x => x.IsActive == true && x.IsDeleted == false && x.ParentID == null).FirstOrDefault().LocationID;
            ViewBag.Governorate = new SelectList(db.Locations.Where(x => x.IsActive == true && x.IsDeleted == false && x.LocationID>4), "LocationID", "LocationName");
            ViewBag.ProjectStatus = new SelectList(db.ProjectStatus.Where(x => x.IsActive == true && x.IsDeleted == false), "ProjectStatusID", "StatusTitle");
            ViewBag.ProjectTypes = new SelectList(db.ProjectTypes.Where(x => x.IsActive == true && x.IsDeleted == false), "ProjectTypeID", "ProjectTypeName");

        }
        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }
        // GET: Projects
        public ActionResult Index(int? id)
        {
            var projects = db.Projects.Where(x => !x.IsDeleted && x.ByUserID == CurrentUser.UserID);
            if (id.HasValue)
                projects = projects.Where(x => x.CompanyID == id);
            projects=projects.Include(p => p.Company).Include(p => p.Location).Include(p => p.ProjectStatu);
            if( db.Companies.Where(x => x.ByUserID == CurrentUser.UserID && x.IsActive).Count()>0)
            {
                ViewBag.ErrorMsg = "";
            }
            return View(projects.ToList());
        }

        

        // GET: Projects/Create
        public ActionResult Create()
        {
            InitPage("Create");
            return View("Project", new Project());
        }

        // POST: Projects/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CompanyID,ProjectName,LocationID,AddressDetails,NoOfUnits,ProjectStatusID,ProjectTypeID")] Project project, HttpPostedFileBase[] files)
        {
            if (ModelState.IsValid)
            {
                project.ByUserID = CurrentUser.UserID;
                project.EntryDate = DateTime.Now;
                project.IsActive = true;
                project.IsDeleted = false;
                db.Projects.Add(project);
                db.SaveChanges();
                AddImages(files, project.ProjectID);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Create");
            return View("Project",project);
        }

        // GET: Projects/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Project project = db.Projects.Find(id);
            if (project == null)
            {
                return HttpNotFound();
            }
            ViewBag.Images = db.Files.Where(x => x.ParentID == id && x.ParentType == "Projects").ToList();
            InitPage("Edit");
            return View("Project", project);
        }

        // POST: Projects/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CompanyID,ProjectID,ProjectName,LocationID,AddressDetails,NoOfUnits,ProjectStatusID,ProjectTypeID")] Project project, HttpPostedFileBase[] files)
        {
            if (ModelState.IsValid)
            {
                var row = db.Projects.Find(project.ProjectID);
                row.AddressDetails = project.AddressDetails;
                row.LocationID = project.LocationID;
                row.NoOfUnits = project.NoOfUnits;
                row.ProjectName = project.ProjectName;
                row.ProjectStatusID = project.ProjectStatusID;
                row.CompanyID = project.CompanyID;
                AddImages(files, row.ProjectID);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            InitPage("Edit");
            return View("Project", project);
        }
        
        // POST: Projects/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            Project project = db.Projects.Find(id);
            project.IsDeleted = true;
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult DeleteImage(long subID, int imgID)
        {
            var fileExist = db.Files.Where(x => x.ParentType == "Projects" && x.ParentID == subID && x.FileID == imgID).FirstOrDefault();
            if (fileExist != null)
            {
                var fileName = fileExist.FileName;
                db.Files.Remove(fileExist);
                db.SaveChanges();
                var imgPath = Request.MapPath("~/Upload/Projects/" + fileName);
                if (System.IO.File.Exists(imgPath))
                    System.IO.File.Delete(imgPath);
            }
            return RedirectToAction("Edit", new { id = subID });
        }
        private void AddImages(HttpPostedFileBase[] images, long parentID)
        {
            if (images != null && images.Length > 0 && images[0] !=null)
            {
                foreach (var f in images)
                {
                    var FileName = string.Format("{0}{1}",Guid.NewGuid(),Path.GetExtension(f.FileName));
                    var FullPath = Request.MapPath("~/Uploads/Projects/" + FileName);
                    f.SaveAs(FullPath);
                    var file = new BrokerNetwork.Models.File();
                    file.CreatedDate = DateTime.Now;
                    file.IsActive = true;
                    file.IsDeleted = false;
                    file.LastUpdated = DateTime.Now;
                    file.OrginalFileName = FileName;
                    file.FileName = FileName;
                    file.ParentID = parentID;
                    file.ParentType = "Projects";
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
