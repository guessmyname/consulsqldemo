using System;
using System.Linq;
using DnsClient;
using DnsClient.Protocol;

namespace uridiscovery
{
   public class UriLookupHelper
    {

       public async Task<Uri> BuildUri(string serviceName)       
        {
        
             var _client = new LookupClient(IPAddress.Loopback,8600);
             var result = await _client.QueryAsync(serviceName, QueryType.SRV);

                if (result.HasError)
                {
                    throw new InvalidOperationException(result.ErrorMessage);
                }

            var srvRecord = result.Answers.OfType<SrvRecord>().FirstOrDefault();

           
            if (srvRecord != null)
            {
                var additionalRecord = result.Additionals.FirstOrDefault(p => p.DomainName.Equals(srvRecord.Target));

                if (additionalRecord is ARecord aRecord)
                {
                    Debug.WriteLine($"Services found at {srvRecord.Target}:{srvRecord.Port} IP: {aRecord.Address}");
                }
                else if (additionalRecord is CNameRecord cname)
                {
                    
                    Debug.WriteLine($"Services found at {srvRecord.Target}:{srvRecord.Port} IP: {cname.CanonicalName}");
                }
            }

             var builder = new UriBuilder;
            return builder.Uri;


        }
    }
}
