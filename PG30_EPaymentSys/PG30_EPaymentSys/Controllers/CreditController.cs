using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Data.Sql;

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


        /*
         * 1 for domestic
         * 0 for overseas
         * -1 for exception
         */
        public int DomesticValidation(int cardNumber)
        {
             String connectionString = "user id=thodo;" +
                                       "password=;" +
                                       "Data Source=localhost;" +
                                       "Trusted_Connection=yes;" +
                                       "database=EC_PAYMENT_SYSTEM_ACB; " +
                                       "connection timeout=30";
            SqlConnection conn = new SqlConnection(connectionString);
            try
            {
                conn.Open();
                String commandString = "";
                SqlCommand cmd = null;
                SqlDataReader reader = null;
                // fetch card account information
                commandString = "select * from PG_30_THETHANHTOAN where sothe = " + cardNumber;
                cmd = new SqlCommand(commandString, conn);
                reader = cmd.ExecuteReader();
                int cardCategoryId = int.Parse(reader["MALOAITHE"].ToString());

                commandString = "select * from PG_30_LOAITHE where maloaithe = " + cardCategoryId;
                cmd = new SqlCommand(commandString, conn);
                reader = cmd.ExecuteReader();
                String cardCategory = reader["TENLOAITHE"].ToString();
                switch (cardCategory)
                {
                    case "VISA DEBIT":
                    case "VISA CREDIT":
                    case "MASTERCARD DEBIT":
                    case "MASTERCARD CREDIT":
                        return 0;
                        break;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return -1;
            }
        
            return 1;
        }



        public void MoneyTransformation(int cardNumber1, float amount, int cardNumber2)
        {
            String connectionString = "user id=thodo;" +
                                       "password=;" +
                                       "Data Source=localhost;" +
                                       "Trusted_Connection=yes;" +
                                       "database=EC_PAYMENT_SYSTEM_ACB; " +
                                       "connection timeout=30";
            SqlConnection conn = new SqlConnection(connectionString);
            try
            {
                conn.Open();
                String commandString = "";
                SqlCommand cmd = null;
                SqlDataReader reader = null;
                // fetch the card number 1 amount
                float amt1 = 0.0f;
                commandString = "select * from PG_30_THETHANHTOAN where sothe = " + cardNumber1;
                cmd = new SqlCommand(commandString, conn);
                reader = cmd.ExecuteReader();
                amt1 = float.Parse(reader["SODUKHADUNG"].ToString());

                // fetch the card number 2 amount
                float amt2 = 0.0f;
                commandString = "select * from PG_30_THETHANHTOAN where sothe = " + cardNumber2;
                cmd = new SqlCommand(commandString, conn);
                reader = cmd.ExecuteReader();
                amt2 = float.Parse(reader["SODUKHADUNG"].ToString());

                // transaction
                amt1 -= amount;
                amt2 += amount;
                // card number 1
                commandString = "alter table pg_30_thethanhtoan set sodukhadung = " + amt1 + "where sothe = " + cardNumber1;
                cmd = new SqlCommand(commandString, conn);
                cmd.ExecuteNonQuery();
                // card number 2
                commandString = "alter table pg_30_thethanhtoan set sodukhadung = " + amt2 + "where sothe = " + cardNumber2;
                cmd = new SqlCommand(commandString, conn);
                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return;
            }
        }

    }
}
