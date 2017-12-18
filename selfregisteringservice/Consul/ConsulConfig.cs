using System.Collections.Generic;

namespace selfregisteringservice
{
public class ConsulConfig
    {
        public string Address { get; set; }
        public string ServiceName { get; set; }
        public string ServiceID { get; set; }

        public List<string> Tags { get; set; }
    }
}