﻿using System.Web;
using System.Web.Mvc;

namespace PG30_EPaymentSys
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}