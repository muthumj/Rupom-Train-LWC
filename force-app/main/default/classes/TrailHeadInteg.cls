public class TrailHeadInteg {
    
    public string Item;
    public string sku;
    
    public void getpost()
    {
        string en = 'https://th-superbadge-apex.herokuapp.com/equipment?_ga=2.236443969.1314435155.1726018942-803527312.1719322572' + sku;
        
        Http p = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(en);
        request.setMethod('GET');
        
        HTTPResponse response = p.send(request);
        
        string body = response.getBody();
        
        system.jsonparser jp = JSON.createParser(body);
        while (jp.nextToken() != null)
        {
            if(jp.gettext() == 'name')
            {
                jp.nextToken();
                Item = (jp.gettext());
            }
        }
        
    }

}