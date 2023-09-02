#ODS SManager Ingress client example

This is example of minimal configuration to communicate with Ingress "SSL" or "http only".  

1. Deploy role Ingress (ssl or http only)
2. Add this configuration to you role. Modify your web srvice configuration like as "test-service" in exmple.
3. Deploy you role. Nginx ingress will be automatically configured to serve 443 and 80 ports for you web service