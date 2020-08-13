using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class FullProperty
    {
        public long PropertyID { get; set; }

        [Required(ErrorMessage = "من فضلك ادخل عنوان الاعلان")]
        public string Title { get; set; }
        public int CustomerID { get; set; }
        public long ByUserID { get; set; }

        [Required(ErrorMessage = "من فضلك اختر المحافظة والمدينة والمنطقة")]
        public int LocationID { get; set; }

        [Required(ErrorMessage = "من فضلك ادخل عنوان الوحدة")]
        public string AddressDetails { get; set; }
        public int? ProjectID { get; set; }
        public bool IsUnit { get; set; }
        public decimal Price { get; set; }
        public bool CanInstallment { get; set; }
        public int? NoOfYears { get; set; }
        public decimal? DownPayment { get; set; }
        public int FloorNum { get; set; }
        public int PropertyFloorTypeID { get; set; }
        public int NoOfProperties { get; set; }
        public int Area { get; set; }
        public int OwnerShipTypeID { get; set; }
        public int PropertyTypeID { get; set; }
        public int PropertyPurposeID { get; set; }
        public bool HasElevator { get; set; }
        public bool HasGarage { get; set; }
        public bool AllowVisitors { get; set; }
        public double? Commission { get; set; }
        public int? CommissionType { get; set; }
        public int NumberOfRooms { get; set; }
        public int NumberOfBathrooms { get; set; }
        public DateTime ReadyDate { get; set; }
        public DateTime LastUpdated { get; set; }
        public string SharedID { get; set; }
        public string Comments { get; set; }
        public bool IsActive { get; set; }
    }
}
