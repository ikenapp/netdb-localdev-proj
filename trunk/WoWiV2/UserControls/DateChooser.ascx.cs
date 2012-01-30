﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_DateChooser : System.Web.UI.UserControl
{
    public String GetText()
    {
        return TextBox1.Text;
    }
    public DateTime GetDate()
    {
        return DateTime.ParseExact(TextBox1.Text,"yyyy/MM/dd",null);
    }
}