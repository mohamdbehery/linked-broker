//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BrokerNetwork.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Project
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Project()
        {
            this.Properties = new HashSet<Property>();
        }
    
        public int CompanyID { get; set; }
        public int ProjectID { get; set; }
        public int ProjectTypeID { get; set; }
        public string ProjectName { get; set; }
        public int LocationID { get; set; }
        public string AddressDetails { get; set; }
        public Nullable<int> NoOfUnits { get; set; }
        public int ProjectStatusID { get; set; }
        public long ByUserID { get; set; }
        public System.DateTime EntryDate { get; set; }
        public bool IsActive { get; set; }
        public bool IsDeleted { get; set; }
    
        public virtual Company Company { get; set; }
        public virtual Location Location { get; set; }
        public virtual ProjectStatu ProjectStatu { get; set; }
        public virtual ProjectType ProjectType { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Property> Properties { get; set; }
    }
}
