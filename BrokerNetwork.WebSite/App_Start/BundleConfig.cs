using System.Web.Optimization;

namespace BrokerNetwork.WebSite
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/scripts/jquery-1.10.2.min.js"));
            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                        "~/scripts/bootstrap.min.js"
                        ));
            bundles.Add(new ScriptBundle("~/angularcp").Include(
                        "~/scripts/angular.min.js"
                         , "~/scripts/ng-file-upload.min.js"
                        ));
            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                 "~/Scripts/jquery.validate.min.js"
                 , "~/Scripts/jquery.validate.unobtrusive.min.js"
                        ));
            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.min.css",
                      "~/Content/bootstrap-theme.min.css",
                      "~/Content/bootstrap-rtl.css",
                      "~/Content/bootstrap-glyphicons.css",
                      "~/Content/Site.css"));
            bundles.Add(new ScriptBundle("~/advsCP").Include(
                  "~/app/adv/advsServices.js"
                  , "~/app/adv/advCPCtrl.js"
                        ));
            // Set EnableOptimizations to false for debugging. For more information,
            // visit http://go.microsoft.com/fwlink/?LinkId=301862
            //BundleTable.EnableOptimizations = false;
            BundleTable.EnableOptimizations = true;
        }
    }
}
