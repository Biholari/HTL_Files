using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetworkLib;

public interface IListener
{
    void OnConnected();
    void OnConnectionFailed(string reason);
    void OnDisconnected();

    void OnLoginSuccess(int userId, List<>);
}
