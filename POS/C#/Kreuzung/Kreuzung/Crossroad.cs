namespace Kreuzung
{
    public interface ICrossroad
    {
        void Cross(Car car);
    }

    public class SimpleCrossroad : ICrossroad
    {
        private readonly object lockObject = new();

        public void Cross(Car car)
        {
            lock (lockObject) 
            { 
                car.Status = "Crossing";
                Thread.Sleep(1000);
                car.Status = "Crossed";
            }
        }
    }

    public class MultiLineCroassroad : ICrossroad
    {
        private SemaphoreSlim northSouthSemaphore = new(1);
        private SemaphoreSlim eastWestSemaphore = new(1);

        public void Cross(Car car)
        {
            if (car.Direction == "North" || car.Direction == "South")
            {
                northSouthSemaphore.Wait();
                try
                {
                    car.Status = "Crossing";
                    Thread.Sleep(1000);
                    car.Status = "Crossed";
                }
                finally
                {
                    northSouthSemaphore.Release();
                }
            }
            else if (car.Direction == "East" || car.Direction == "West")
            {
                eastWestSemaphore.Wait();
                try
                {
                    car.Status = "Crossing";
                    Thread.Sleep(1000);
                    car.Status = "Crossed";
                }
                finally
                {
                    eastWestSemaphore.Release();
                }
            }
        }
    }
}
