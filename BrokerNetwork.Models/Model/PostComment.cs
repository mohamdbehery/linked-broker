using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class PostComment
    {
        public long CommentID { get; set; }
        public long UserID { get; set; }
        public string CommentMsg { get; set; }
        public DateTime CreatedDate { get; set; }
        public string UserName { get; set; }
        public string UserImg { get; set; }
    }
}
