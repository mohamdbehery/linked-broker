using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using System.Web.Http.Description;
using BrokerNetwork.Models;
using BrokerNetwork.Models.Model;

namespace BrokerNetwork.API.Controllers
{
    public class SharedController : ApiController
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(User as ClaimsPrincipal);
            }
        }

        // GET: api/PropertyTypes
        [Route("api/Locations/{LocationID}")]
        public IHttpActionResult GetLocations(int? LocationID)
        {
            LocationID = LocationID == 0 ? null : LocationID;
            
            return Ok(db.Locations.Where(x => x.IsActive && !x.IsDeleted && x.ParentID == LocationID).Select(x => new { x.LocationID, x.LocationName }));
        }

        [Route("api/GetProjectLocation/{ProjectID}")]
        public IHttpActionResult GetProjectLocation(int ProjectID)
        {
            var LocationID = db.Projects.Where(x => x.ProjectID == ProjectID).FirstOrDefault().LocationID;

            return Ok(LocationID);
        }
        

        [Route("api/GetAreaLocations/{AreaID}")]
        public IHttpActionResult GetAreaLocations(int AreaID)
        {
            var Locations = (from area in db.Locations
                        join city in db.Locations on area.ParentID equals city.LocationID
                        where area.LocationID == AreaID
                        select new
                        {
                            CityID = area.ParentID,
                            GovID = city.ParentID
                        }).FirstOrDefault();
            return Ok(Locations);
        }

        [Route("api/PropertyTypes")]
        public IHttpActionResult GetPropertyTypes()
        {
            return Ok(db.PropertyTypes.Where(x => x.IsActive && !x.IsDeleted).Select(x => new { x.PropertyTypeID, x.PropTypeTitle }));
        }
        [Route("api/ProjectTypes")]
        public IHttpActionResult GetProjectTypes()
        {
            return Ok(db.ProjectTypes.Where(x => x.IsActive==true && x.IsDeleted !=true).Select(x => new { x.ProjectTypeID, x.ProjectTypeName }));
        }
        [Route("api/CustomerStatus")]
        public IQueryable<CustomerStatu> GetCustomerStatus()
        {
            return db.CustomerStatus.Where(x => x.IsActive && !x.IsDeleted);
        }

        [Route("api/OwnerShipTypes")]
        public IQueryable<OwnerShipType> GetOwnerShipTypes()
        {
            return db.OwnerShipTypes.Where(x => x.IsActive && !x.IsDeleted);
        }
        [Route("api/RequestStatus")]
        public IQueryable<RequestStatu> GetRequestStatus()
        {
            return db.RequestStatus.Where(x => x.IsActive && !x.IsDeleted);
        }
        [Route("api/PropertyPurposes")]
        public IQueryable<PropertyPurpose> GetPropertyPurposes()
        {
            return db.PropertyPurposes.Where(x => x.IsActive && !x.IsDeleted);
        }
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool PropertyTypeExists(int id)
        {
            return db.PropertyTypes.Count(e => e.PropertyTypeID == id) > 0;
        }

        [HttpPost]
        [Route("api/GetCustomers")]
        public IHttpActionResult GetCustomers([FromBody] GridDataSource gSource)
        {
            var dat = db.Customers.Where(x => !x.IsDeleted && x.ByUserID==CurrentUser.UserID).AsQueryable();
            if (gSource.Filter != null && gSource.Filter.Filters.Count > 0)
            {
                var custName = gSource.Filter.Filters.Where(x => x.Field.Equals("CustomerName", System.StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
                var custstatus = gSource.Filter.Filters.Where(x => x.Field.Equals("CustomerStatusTitle", System.StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
                int status;
                if (custName != null && !string.IsNullOrEmpty(custName.Value))
                {
                    dat = dat.Where(x => x.CustomerName.Contains(custName.Value));
                }
                if (custstatus != null && int.TryParse(custstatus.Value,out status))
                {
                    dat = dat.Where(x => x.CustomerStatusID == status);
                }
            }
            dat = dat.OrderByDescending(x => x.CompanyID);
            
            var t = dat.Count();
            dat = dat
                .Skip(gSource.Skip).Take(gSource.Take);

            var d = dat.Include(x=>x.CustomerStatu).Select(x => new
            {
                x.CustomerID,
                x.CreatedDate,
                x.CustomerName,
                x.CustomerStatu.CustomerStatusTitle
            }).ToList();
            return Content(HttpStatusCode.OK, new { data = d, total = t });
        }

        [HttpPost]
        [Route("api/DeleteCustomers/{id}")]
        public IHttpActionResult DeleteConfirmed(long id)
        {
            Customer customer = db.Customers.Find(id);
            customer.IsDeleted = true;
            db.SaveChanges();
            return Ok();
        }
        // GET: api/PropertyTypes
        [Route("api/AddCompanyBroker/{companyID}/{searchData}")]
        public IHttpActionResult AddCompanyBroker(int companyID,string searchData)
        {
            //if()
            return Ok(db.Locations.Where(x => x.IsActive && !x.IsDeleted ).Select(x => new { x.LocationID, x.LocationName }));
        }
        [HttpPost]
        [Route("api/AddComment/{postType}/{postID}")]
        public IHttpActionResult AddComment([FromBody]PostComment comment,int postType,long postID)
        {
            if(User.Identity.IsAuthenticated)
            {
                var comm = new Comment();
                comm.CreatedDate = DateTime.Now;
                comm.UserID = CurrentUser.UserID;
                comm.CommentMsg = comment.CommentMsg;
                comm.PostID=postID;
                comm.PostType = postType;
                db.Comments.Add(comm);
                db.SaveChanges();
                comm = db.Comments.Where(x=>x.CommentID==comm.CommentID).Include("User").FirstOrDefault();
                return Ok(new { comm.CommentID, comm.CreatedDate, UserImg = comm.User.ProfileImgPath, comm.UserID, UserName = comm.User.FullName, comm.CommentMsg });
            }
            return Ok();
        }
    }
}