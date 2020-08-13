using BrokerNetwork.Models;
using BrokerNetwork.Models.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Business
{
    public class BLayer
    {
        private BrokerNetworkConnection db = new BrokerNetworkConnection();

        public static User GetUserByLogin(string email, string password)
        {
            User us = null;
            using (var db = new BrokerNetworkConnection())
            {
                us = db.Users.Where(x => x.UserPassword == password && x.Email == email).FirstOrDefault();
            }
            return us;
        }

        protected AppUser CurrentUser
        {
            get
            {
                return new AppUser(System.Web.HttpContext.Current.User as ClaimsPrincipal);
            }
        }
        public FilterList<PropertyShortDisplay> GetAllPropertiesLanding(FilterList<PropertyShortDisplay> filter, PropertiesDisplayType display = PropertiesDisplayType.AllBrokers)
        {
            var query = db.Properties.Where(x => !x.IsDeleted);
            if (display == PropertiesDisplayType.AllBrokers)
            {
                if (CurrentUser.UserID > 0)
                {
                    query = query.Where(x => x.IsActive && (x.SharedID == "All" || x.ByUserID == CurrentUser.UserID));
                }
                else
                {
                    query = query.Where(x => x.IsActive && x.SharedID == "All");
                }
                //if(CurrentUser.IsVerfied)
                //    query = query.Where(x => x.IsActive && (x.SharedID == "All" || x.SharedID== "VerifiedBroker"));
                //else
                //    query = query.Where(x => x.IsActive && x.SharedID == "All");
            }
            else if (display == PropertiesDisplayType.CurrentUser)
                query = query.Where(x => x.ByUserID == CurrentUser.UserID);
            else if (display == PropertiesDisplayType.Visitor)
                query = query.Where(x => x.IsActive && x.AllowVisitors);
            else if (display == PropertiesDisplayType.SpecificUser)
                query = query.Where(x => x.IsActive && x.SharedID == "All" && x.ByUserID == filter.ByUserID);
            if (filter.pTo > 0 && filter.pFrom > 0)
                query = query.Where(x => x.Price >= filter.pFrom && x.Price <= filter.pTo);
            if (filter.aTo > 0 && filter.aFrom > 0)
                query = query.Where(x => x.Area >= filter.aFrom && x.Area <= filter.aTo);
            if (filter.isV)
                query = query.Where(x => x.User.IsVerfied == true);
            if (filter.ptID > 0)
                query = query.Where(x => x.Project.ProjectTypeID == filter.ptID);
            if (filter.ftID > 0)
                query = query.Where(x => x.PropertyFloorTypeID == filter.ftID);
            if (filter.utID > 0)
                query = query.Where(x => x.PropertyTypeID == filter.utID);
            if (filter.rID > 0)
                query = query.Where(x => x.LocationID == filter.rID);
            else if (filter.ctyID > 0)
                query = query.Where(x => db.Locations.Where(z => z.ParentID == filter.ctyID).Select(z => z.LocationID).Contains(x.LocationID));

            if (filter.projectID.HasValue)
                query = query.Where(x => x.ProjectID == filter.projectID);
            filter.TotalCount = query.Count();
            query = query.OrderByDescending(x => x.PropertyID).Skip(filter.PageSize * (filter.PageNum - 1)).Take(filter.PageSize);
            filter.Data = query.Select(x => new PropertyShortDisplay()
            {
                EntryDate = x.EntryDate,
                FloorTypeTitle = x.PropertyFloorType.FloorTypeTitle,
                Title = x.Title,
                LocationName = x.Location.LocationName,
                OwnerShipTitle = x.OwnerShipType.OwnerShipTitle,
                PropertyID = x.PropertyID,
                PropPurposeTitle = x.PropertyPurpose.PropPurposeTitle,
                PropTypeTitle = x.PropertyType.PropTypeTitle,
                AddressDetails = x.AddressDetails,
                Area = x.Area,
                UserID = x.ByUserID,
                Price=x.Price,
                NumberOfRooms=x.NumberOfRooms,
                DefaultImage = db.Files.Where(z => z.IsActive == true && z.IsDeleted != true && z.ParentType == "Properties" && z.ParentID == x.PropertyID).Select(z => z.FileName).FirstOrDefault()
            }).ToList();

            return filter;
        }
        public PropertyDisplay GetPropertyDetails(long propertyID, PropertiesDisplayType display = PropertiesDisplayType.AllBrokers)
        {
            PropertyDisplay lst = null;
            var query = db.Properties.Where(x => !x.IsDeleted && x.PropertyID == propertyID && x.IsActive);
            if (!System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
                query = query.Where(x => x.AllowVisitors);
            else
                query = query.Where(x => x.SharedID == "All");
            var row = query.FirstOrDefault();
            if (row == null) return null;
            lst = query.Select(x => new PropertyDisplay()
            {
                EntryDate = x.EntryDate,
                FloorTypeTitle = x.PropertyFloorType.FloorTypeTitle,
                Title = x.Title,
                LocationName = x.Location.LocationName,
                OwnerShipTitle = x.OwnerShipType.OwnerShipTitle,
                PropertyID = x.PropertyID,
                PropPurposeTitle = x.PropertyPurpose.PropPurposeTitle,
                PropTypeTitle = x.PropertyType.PropTypeTitle,
                AddressDetails = x.AddressDetails,
                ReadyDate = x.ReadyDate,
                Area = x.Area,
                Comments = x.Comments,
                Commission = x.Commission,
                CommissionType = x.CommissionType,
                FloorNum = x.FloorNum,
                NumberOfBathrooms = x.NumberOfBathrooms,
                NumberOfRooms = x.NumberOfRooms,
                ProjectID = x.ProjectID,
                FullName=x.User.FullName,
                CompanyID = x.Project != null ? x.Project.CompanyID : 0,
                CompanyName = (x.Project != null && x.Project.Company != null) ? x.Project.Company.CompanyName : null,
                ProjectName = x.Project != null ? x.Project.ProjectName : null,
                Contacts = (x.Project != null && x.Project.Company != null) ? x.Project.Company.Contacts : x.User.Mobile,
                ContactsForBrokers = (x.Project != null && x.Project.Company != null) ? x.Project.Company.ContactsForBrokers : null,
                Price = x.Price,
                UserID = x.ByUserID,
                AreaID=x.LocationID,
                AreaName=x.Location.LocationName,
                CityID=x.Location.ParentID,
                Images = db.Files.Where(z => z.IsActive == true && z.IsDeleted != true && z.ParentType == "Properties" && z.ParentID == x.PropertyID).Select(z => z.FileName).ToList(),
                HasElevator = x.HasElevator,
                HasGarage = x.HasGarage,
                CanInstallment = x.CanInstallment,
                DownPayment = x.DownPayment,
                NoOfYears = x.NoOfYears
            }).FirstOrDefault();
            var city = db.Locations.Where(z => z.LocationID == lst.CityID).FirstOrDefault();
            lst.CityName = city.LocationName;
            lst.GovernorateID = city.ParentID;
            lst.GovernorateName = db.Locations.Where(z => z.LocationID == lst.GovernorateID).Select(x=>x.LocationName).FirstOrDefault();
            lst.PostComments = db.Comments.Where(x => x.PostID == propertyID && x.PostType == 1).OrderByDescending(x=>x.CreatedDate).Select(x => new PostComment() {CommentID=x.CommentID,CommentMsg=x.CommentMsg,CreatedDate=x.CreatedDate.Value,UserID=x.UserID.Value,UserImg=x.User.ProfileImgPath,UserName=x.User.FullName }).ToList();
            if (System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var matchedQuery = db.PropertyRequests.Where(z => z.IsActive && !z.IsDeleted && z.ByUserID == CurrentUser.UserID && (z.OwnerShipTypeID == row.OwnerShipTypeID || z.OwnerShipTypeID == null) && (z.PropertyFloorTypeID == row.PropertyFloorTypeID || z.PropertyFloorTypeID == null) && (z.LocationIDs == row.LocationID || z.LocationIDs == null) && (z.CityID == lst.CityID || z.CityID == null) && (z.GovID == lst.GovernorateID || z.GovID == null) && (z.PropertyPurposeID == row.PropertyPurposeID || z.PropertyPurposeID == null) && (z.MinPrice <= lst.Price && z.MaxPrice >= lst.Price) && (z.MinPrice == 0 && z.MaxPrice == 0) && (z.MinArea <= lst.Area && z.MaxArea <= lst.Area) && (z.MinArea == 0 && z.MinArea == 0));

                lst.MatchedRequests = matchedQuery.Select(x => new PropertyShortDisplay()
                {
                    EntryDate = x.EntryDate,
                    FloorTypeTitle = x.PropertyFloorType.FloorTypeTitle,
                    Title = x.Title,
                    LocationName = x.Location.LocationName,
                    OwnerShipTitle = x.OwnerShipType.OwnerShipTitle,
                    PropertyID = x.RequestID,
                    PropPurposeTitle = x.PropertyPurpose.PropPurposeTitle,
                    PropTypeTitle = x.PropertyType.PropTypeTitle,
                    AddressDetails = x.AddressDetails,
                    UserID = x.ByUserID
                }).ToList();
            }
            return lst;
        }

        public FilterList<PropertyShortDisplay> GetAllPropertiesRequests(FilterList<PropertyShortDisplay> filter)
        {
            filter.DataType = FilterListDataType.Requests;
            var query = db.PropertyRequests.Where(x => !x.IsDeleted && x.IsActive);

            if (filter.ByUserID > 0)
                query = query.Where(x => x.ByUserID == filter.ByUserID);
            query = query.OrderByDescending(x => x.RequestID).Skip(filter.PageSize * (filter.PageNum - 1)).Take(filter.PageSize);

            filter.Data = query.Select(x => new PropertyShortDisplay()
            {
                EntryDate = x.EntryDate,
                FloorTypeTitle = x.PropertyFloorType.FloorTypeTitle,
                Title = x.Title,
                LocationName = x.Location.LocationName,
                OwnerShipTitle = x.OwnerShipType.OwnerShipTitle,
                PropertyID = x.RequestID,
                PropPurposeTitle = x.PropertyPurpose.PropPurposeTitle,
                PropTypeTitle = x.PropertyType.PropTypeTitle,
                AddressDetails = x.AddressDetails,
                UserID = x.ByUserID,
            }).OrderByDescending(x => x.PropertyID).ToList();

            return filter;
        }
        public RequestDisplay GetRequestDetails(long propertyID)
        {
            RequestDisplay lst = null;
            var query = db.PropertyRequests.Where(x => !x.IsDeleted && x.RequestID == propertyID && x.IsActive);
            var singleRow = query.FirstOrDefault();
            if (singleRow == null) return null;
            lst = query.Select(x => new RequestDisplay()
            {
                EntryDate = x.EntryDate,
                FloorTypeTitle = x.PropertyFloorType.FloorTypeTitle,
                Title = x.Title,
                LocationName = x.Location.LocationName,
                OwnerShipTitle = x.OwnerShipType.OwnerShipTitle,
                PropertyID = x.RequestID,
                PropPurposeTitle = x.PropertyPurpose.PropPurposeTitle,
                PropTypeTitle = x.PropertyType.PropTypeTitle,
                AddressDetails = x.AddressDetails,
                Comments = x.Comments,
                MinArea = x.MinArea,
                MaxArea = x.MaxArea,
                MinPrice = x.MinPrice,
                MaxPrice = x.MaxPrice,
                UserID = x.ByUserID,
                FullName = db.Users.Where(z => z.UserID == x.ByUserID).Select(z => z.FullName).FirstOrDefault()
            }).FirstOrDefault();
            var userProperties = db.Properties.Where(z => z.IsActive && !z.IsDeleted && z.ByUserID == CurrentUser.UserID).AsQueryable();
            if(singleRow.MaxArea>0)
                userProperties = userProperties.Where(x => (x.Area >= singleRow.MinArea && x.Area <= singleRow.MaxPrice));
            if (singleRow.MaxPrice > 0)
                userProperties = userProperties.Where(x => (x.Price >= singleRow.MinPrice && x.Price <= singleRow.MaxPrice));
            if (singleRow.OwnerShipTypeID.HasValue)
                userProperties = userProperties.Where(x => x.OwnerShipTypeID == singleRow.OwnerShipTypeID);
            if (singleRow.LocationIDs.HasValue)
                userProperties = userProperties.Where(x => x.LocationID == singleRow.LocationIDs);
            if (singleRow.PropertyFloorTypeID.HasValue)
                userProperties = userProperties.Where(x => x.PropertyFloorTypeID == singleRow.PropertyFloorTypeID);
            if (singleRow.PropertyPurposeID.HasValue)
                userProperties = userProperties.Where(x => x.PropertyPurposeID == singleRow.PropertyPurposeID);

            lst.MatchedProperties = userProperties.OrderByDescending(z => z.EntryDate).Select(z => new PropertyShortDisplay() { PropertyID = z.PropertyID, AddressDetails = z.AddressDetails, Area = z.Area, EntryDate = z.EntryDate, Title = z.Title, LocationName = z.Location.LocationName, OwnerShipTitle = z.OwnerShipType.OwnerShipTitle, PropPurposeTitle = z.PropertyPurpose.PropPurposeTitle, FloorTypeTitle = z.PropertyFloorType.FloorTypeTitle, PropTypeTitle = z.PropertyType.PropTypeTitle, DefaultImage = db.Files.Where(y => y.IsActive == true && y.IsDeleted != true && y.ParentType == "Properties" && y.ParentID == z.PropertyID).Select(y => y.FileName).FirstOrDefault() }).ToList();
            lst.PostComments = db.Comments.Where(x => x.PostID == propertyID && x.PostType == 2).OrderByDescending(x => x.CreatedDate).Select(x => new PostComment() {CommentID=x.CommentID,CommentMsg=x.CommentMsg,CreatedDate=x.CreatedDate.Value,UserID=x.UserID.Value,UserImg=x.User.ProfileImgPath,UserName=x.User.FullName }).ToList();
            
            return lst;
        }
    }
}