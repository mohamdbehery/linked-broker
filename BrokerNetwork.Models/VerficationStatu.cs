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
    
    public partial class VerficationStatu
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public VerficationStatu()
        {
            this.VerficationRequests = new HashSet<VerficationRequest>();
        }
    
        public int VerfiedStatusID { get; set; }
        public string VerfiedStatusTitle { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<VerficationRequest> VerficationRequests { get; set; }
    }
}
