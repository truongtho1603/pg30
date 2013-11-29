using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace TMDT_PG30.Controllers
{
    public class DefaultController : Controller
    {
        public ActionResult Home()
        {
            return View();
        }

        public ActionResult Personal()
        {
            return View();
        }

        public ActionResult Business()
        {
            return View();
        }
    }
}
