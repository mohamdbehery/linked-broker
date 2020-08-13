using BrokerNetwork.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BrokerNetwork.WebSite.Models
{
    public class CompanyBrokersModel
    {
        public CompanyBrokersModel()
        {
            SearchStatus = true;
        }
        public int CompanyID { get; set; }
        [Required]
        public string SearchBroker { get; set; }
        public ICollection<CompanyBroker> Brokers { get; set; }
        public bool SearchStatus { get; set; }
        public string Msg { get; set; }
    }
}