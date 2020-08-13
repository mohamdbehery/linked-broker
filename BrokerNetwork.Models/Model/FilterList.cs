using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class FilterList<T> : Paging where T :class
    {
        public FilterList()
        {
            DataType = FilterListDataType.Properties;
        }
        public FilterListDataType DataType { get; set; }
        public int? projectID { get; set; }
        public List<T> Data { get; set; }
        public long ByUserID { get; set; }
        //Price From
        public long pFrom { get; set; }
        //Price To
        public long pTo { get; set; }
        //Area From
        public int aFrom { get; set; }
        //Area To
        public int aTo { get; set; }
        public bool isV { get; set; }
        //Property Type or Unit Type
        public int utID { get; set; }
        //Region or Location ID
        public int rID { get; set; }
        public int govID { get; set; }
        public int ctyID { get; set; }

        //Project Tpe ID
        public int ptID { get; set; }
        public int ftID { get; set; }
    }
    public enum FilterListDataType { Properties,Requests}
}
