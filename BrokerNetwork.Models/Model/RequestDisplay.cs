using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class RequestDisplay : PropertyShortDisplay
    {
        public RequestDisplay()
        {
            
        }

        public string FullName { get; set; }
        public string Comments { get; set; }
        public decimal? MinPrice { get; set; }
        public decimal? MaxPrice { get; set; }

        public int? MinArea { get; set; }
        public int? MaxArea { get; set; }
        public List<PropertyShortDisplay> MatchedProperties { get; set; }
        public List<PostComment> PostComments { get; set; }

    }
}
