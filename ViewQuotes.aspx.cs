using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Odbc;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewQuotes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["MySQLConnStr"].ConnectionString))
            {
                connection.Open();
                using (OdbcCommand command = new OdbcCommand(
                    "SELECT * FROM quote ORDER BY created DESC", connection))
                {
                    OdbcDataReader reader = command.ExecuteReader();
                    rptQuotes.DataSource = reader;
                    rptQuotes.DataBind();
                }
                connection.Close();
            }
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message.ToString();
        }
    }
}