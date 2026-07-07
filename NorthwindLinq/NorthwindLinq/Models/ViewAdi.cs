using System;
using System.Collections.Generic;

namespace NorthwindLinq.Models;

public partial class ViewAdi
{
    public string ProductName { get; set; } = null!;

    public decimal? UnitPrice { get; set; }

    public decimal? KdvliFiyat { get; set; }
}
