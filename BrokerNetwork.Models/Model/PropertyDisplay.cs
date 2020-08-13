using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class PropertyDisplay: PropertyShortDisplay
    {
        public PropertyDisplay()
        {
            
        }
        private List<string> _Images;
        public List<string> Images
        {
            get
            {
                return _Images;
            }
            set
            {
                _Images = value;
                if (_Images != null && _Images.Count > 0)
                    DefaultImage = _Images[0];
            }
        }
        public string Comments { get; set; }
        public int FloorNum { get; set; }

        //public int NumberOfRooms { get; set; }
        public int NumberOfBathrooms { get; set; }
        //public decimal Price { get; set; }
        public double? Commission { get; set; }
        public int? CommissionType { get; set; }
        public int? AreaID { get; set; }
        public string AreaName { get; set; }
        public int? CityID { get; set; }
        public string CityName { get; set; }
        public int? GovernorateID { get; set; }
        public string GovernorateName { get; set; }
        public int? ProjectID { get; set; }
        public int? CompanyID { get; set; }
        public string ProjectName { get; set; }
        public string CompanyName { get; set; }
        public string Contacts { get; set; }
        public string ContactsForBrokers { get; set; }
        public string FullName { get; set; }
        public List<PropertyShortDisplay> MatchedRequests { get; set; }
        
        public bool CanInstallment { get; set; }
        public int? NoOfYears { get; set; }

        public decimal? DownPayment { get; set; }
        public bool HasElevator { get; set; }
        public bool HasGarage { get; set; }
        public DateTime ReadyDate { get; set; }
        public List<PostComment> PostComments { get; set; }
    }
}
