<%@ WebHandler Language="C#" Class="SubmitForm" %>

using System;
using System.Web;
using System.Net.Mail;
using System.Configuration;
using System.Data.Odbc;

public class SubmitForm : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        try
        {
            var quote = new Quote();
            quote.Name = context.Request["q3_name"].Trim();
            quote.Email = context.Request["q4_email"].Trim();
            quote.Phone = context.Request["q5_phoneNumber"].Trim();
            quote.Vehicle = context.Request["q14_vehicleMake"].Trim();
            quote.Pickup = context.Request["q15_pickupCitystate"].Trim();
            quote.Delivery = context.Request["q16_deliveryCitystate"].Trim();
            quote.Run = context.Request["q11_run"];
            quote.Trailer = context.Request["q13_trailer"];
            quote.Notes = context.Request["q7_additionalInfo"].Trim();

            // Persist form fields to database
            //this.SaveForm(quote);

            // Send SMS message
            this.SendSMS(quote);

            // Send email message
            this.SendEmail(quote);
        }
        catch(Exception ex)
        {
            context.Response.Redirect("/?response=error");
        }

        context.Response.Redirect("/?response=success");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    private void SaveForm(Quote quote)
    {
        using (OdbcConnection connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["MySQLConnStr"].ConnectionString))
        {
            connection.Open();
            using (OdbcCommand command = new OdbcCommand(
                "INSERT INTO quote (created, name, email, phone, vehicle, pickup, delivery, run, trailer, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", connection))
            {
                command.Parameters.AddWithValue("@p1", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                command.Parameters.AddWithValue("@p2", quote.Name);
                command.Parameters.AddWithValue("@p3", quote.Email);
                command.Parameters.AddWithValue("@p4", quote.Phone);
                command.Parameters.AddWithValue("@p5", quote.Vehicle);
                command.Parameters.AddWithValue("@p6", quote.Pickup);
                command.Parameters.AddWithValue("@p7", quote.Delivery);
                command.Parameters.AddWithValue("@p8", quote.Run);
                command.Parameters.AddWithValue("@p9", quote.Trailer);
                command.Parameters.AddWithValue("@p10", quote.Notes);
                command.ExecuteNonQuery();
            }
            connection.Close();
        }
    }

    private void SendSMS(Quote quote)
    {
        var message = new MailMessage();
        message.To.Add(ConfigurationManager.AppSettings["SMSNumber"].ToString());
        //message.From = new MailAddress(ConfigurationManager.AppSettings["FromEmailAddress"].ToString());
        try
        {
            message.From = new MailAddress(quote.Email);
        }
        catch
        {
            message.From = new MailAddress("no-reply@slautotransport.com");
        }
        message.Subject = "A quote has been requested";
        message.IsBodyHtml = false;

        string body = "A quote has been requested:\n\n";
        body += quote.ToString();
        message.Body = body;

        SmtpClient client = new SmtpClient();
        client.Send(message);
    }

    private void SendEmail(Quote quote)
    {
        var message = new MailMessage();
        message.To.Add(ConfigurationManager.AppSettings["ToEmailAddress"].ToString());
        //message.From = new MailAddress(ConfigurationManager.AppSettings["FromEmailAddress"].ToString());    
        try
        {
            message.From = new MailAddress(quote.Email);
        }
        catch
        {
            message.From = new MailAddress("no-reply@transport.com");
        }
        message.Subject = "A quote has been requested";
        message.IsBodyHtml = false;

        string body = "A quote has been requested:\n\n";
        body += quote.ToString();
        message.Body = body;

        SmtpClient client = new SmtpClient();
        client.Send(message);
    }
}