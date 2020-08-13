using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class GridDataSource
    {
        public int Page {get; set;}
        public int PageSize{get; set;}
        public int Skip { get; set; }
        public int Take { get; set; }
        public List<GridSort> Sort { get; set; }
        public GridFilters Filter { get; set; }
    }
    public class GridSort
    {
        public string Field { get; set; }
        public string Dir { get; set; }
    }
    public class GridFilter
    {
        public string Operator { get; set; }
        public string Field { get; set; }
        public string Value { get; set; }
    }

    public class GridFilters
    {
        public List<GridFilter> Filters { get; set; }
        public string Logic { get; set; }
    }

}
