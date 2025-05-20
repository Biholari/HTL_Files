using DataModel;
using LinqToDB;

namespace Waldwunder_Verwaltung;

public class WaldwunderDataService
{
    public static async Task<List<Waldwunder>> GetAllWaldwundersAsync()
    {
        using var db = new WaldwunderDb();
        var data = await db.Waldwunders.ToListAsync();
        return data;
    }

    public static async Task<Waldwunder?> GetWaldwunderByIdAsync(long id)
    {
        using var db = new WaldwunderDb();
        return await db.Waldwunders.FindAsync(id);
    }

    public static async Task<List<Bilder>> GetBildersForWaldwunderAsync(long wonderId)
    {
        using var db = new WaldwunderDb();
        return await db.Bilders
            .Where(b => b.Wonder == wonderId)
            .ToListAsync();
    }

    public static async void AddNewWaldwunder(Waldwunder newWaldwunder)
    {
        using var db = new WaldwunderDb();
        await db.InsertAsync(newWaldwunder);
    }
}
