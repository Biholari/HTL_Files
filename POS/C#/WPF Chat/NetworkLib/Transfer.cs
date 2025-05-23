using System.Net.Sockets;
using System.Xml.Serialization;

namespace NetworkLib;

public class Transfer<T>(TcpClient client)
{
    private readonly TcpClient _client = client;
    private readonly StreamReader _reader = new(client.GetStream());
    private readonly StreamWriter _writer = new(client.GetStream());
    private readonly XmlSerializer _serializer = new(typeof(T));

    public async Task<T> SendAsync(T data)
    {
        // Serialize the object to XML
        using (var stringWriter = new StringWriter())
        {
            _serializer.Serialize(stringWriter, data);
            var xmlData = stringWriter.ToString();
            // Send the XML data over the network
            await _writer.WriteLineAsync(xmlData);
            await _writer.FlushAsync();
        }
        // Read the response from the server
        var response = await _reader.ReadLineAsync() ?? throw new Exception("No response from server");

        // Deserialize the response back to an object
        using var stringReader = new StringReader(response);
        return (T)_serializer.Deserialize(stringReader);
    }
}
