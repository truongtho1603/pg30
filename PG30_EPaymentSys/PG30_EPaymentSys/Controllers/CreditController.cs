using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PG30_EPaymentSys.Controllers
{
    public class CreditController : Controller
    {
        //
        // GET: /Credit/

        public ActionResult Index()
        {
            return View();
        }

        public bool CreditValidation(int cardNumber)
        {
            // card number validtion
            string code = cardNumber.ToString();
            int sum1 = 0;
            int sum2 = 0;
            while (cardNumber != 0)
            {
                sum1 += cardNumber % 10;
                cardNumber /= 10;

                int token = cardNumber % 10;
                cardNumber /= 10;
                sum2 += token * 2;
            }
            if ((sum1 + sum2) % 10 == 0)
            {
                return true;
            }
            return false;
        }

        public bool DomesticValidation(int cardNumber)
        {
            return false;
        }


    }
}
