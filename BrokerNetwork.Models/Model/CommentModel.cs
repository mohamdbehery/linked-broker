using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrokerNetwork.Models.Model
{
    public class CommentModel
    {
        public CommentsPostTypes PostType { get; set; }
        public long PostID { get; set; }
        public List<PostComment> Comments { get; set; }
    }
    public enum CommentsPostTypes
    {
        Property=1,
        PropertyRequest
    }
}
