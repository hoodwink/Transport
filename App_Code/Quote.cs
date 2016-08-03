using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Quote
/// </summary>
public class Quote
{
    public string Name { get; set; }

    public string Email { get; set; }

    public string Phone { get; set; }

    public string Vehicle { get; set; }

    public string Pickup { get; set; }

    public string Delivery { get; set; }

    public string Run { get; set; }

    public string Trailer { get; set; }

    public string Notes { get; set; }

    public override string ToString()
    {
        string output = string.Empty;

        output += "Name: " + this.Name + "\n";
        output += "Email: " + this.Email + "\n";
        output += "Phone Number: " + this.Phone + "\n";
        output += "Vehicle Make and Model: " + this.Vehicle + "\n";
        output += "Pickup City/State: " + this.Pickup + "\n";
        output += "Delivery City/State: " + this.Delivery + "\n";
        output += "Run?: " + this.Run + "\n";
        output += "Trailer: " + this.Trailer + "\n";
        output += "Notes: " + this.Notes + "\n";

        return output;
    }
}