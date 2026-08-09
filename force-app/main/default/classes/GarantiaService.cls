public class GarantiaService {
    
    @future(callout=true)
    public static void consultarGarantiaExterna(Set<Id> idsDosCasos) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://dummyjson.com/products/1');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> resultado = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            String infoGarantia = (String) resultado.get('warrantyInformation');
            
            List<Case> chamadosParaAtualizar = [SELECT Id, Description FROM Case WHERE Id IN :idsDosCasos];
            
            for (Case chamado : chamadosParaAtualizar) {
                chamado.Description = chamado.Description + '\n\n--- RETORNO DA API EXTERNA ---\nStatus da Garantia: ' + infoGarantia;
            }
            update chamadosParaAtualizar;
        }
    }
}