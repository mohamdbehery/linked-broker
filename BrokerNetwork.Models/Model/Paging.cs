using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class Paging
    {
        public Paging()
        {
            PageNum = 1;
            PageSize = 50;
            ShowPagingButtons = true;
        }
        public int PageNum { get; set; }
        public int PageSize { get; set; }
        public int TotalCount { get; set; }
        public int PagesCount
        {
            get
            {
                int pageCount = TotalCount / PageSize;
                if (TotalCount % PageSize > 0) pageCount++;
                return pageCount;
            }
        }
        public bool ShowPagingButtons { get; set; }
    }
}
