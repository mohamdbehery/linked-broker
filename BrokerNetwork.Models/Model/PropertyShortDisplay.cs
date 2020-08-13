using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class PropertyShortDisplay
    {
        public long PropertyID { get; set; }
        public string LocationName { get; set; }
        public string Title { get; set; }
        public string FloorTypeTitle { get; set; }
        public string PropPurposeTitle { get; set; }
        public string PropTypeTitle { get; set; }
        public string OwnerShipTitle { get; set; }
        public DateTime EntryDate { get; set; }
        public DateTime LastEditDate { get; set; }
        public int Area { get; set; }
        public string AddressDetails { get; set; }
        public long UserID { get; set; }
        public int NumberOfRooms { get; set; }
        public decimal Price { get; set; }
        public string DefaultImage { get; set; }
    }
}
