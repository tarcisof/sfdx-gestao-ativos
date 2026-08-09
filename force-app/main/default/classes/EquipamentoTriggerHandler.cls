public class EquipamentoTriggerHandler {
    
    public static void verificarEquipamentoComDefeito(List<Equipamento__c> equipamentosNovos, Map<Id, Equipamento__c> equipamentosAntigos) {
        
        List<Case> chamadosParaCriar = new List<Case>();
        
        for (Equipamento__c equip : equipamentosNovos) {
            
            Equipamento__c equipAntigo = equipamentosAntigos.get(equip.Id);
            
            if (equip.Status__c == 'Com Defeito' && equipAntigo.Status__c != 'Com Defeito') {
                Case novoChamado = new Case(); 
                
                novoChamado.Subject = 'Manutenção Urgente: ' + equip.Name;
                novoChamado.Status = 'New';
                novoChamado.Priority = 'High';
                novoChamado.Description = 'Sistema detectou falha no equipamento. Iniciar diagnóstico.';
                novoChamado.Equipamento__c = equip.Id;
                
                chamadosParaCriar.add(novoChamado);
            }
        }
        
        if (!chamadosParaCriar.isEmpty()) {
            insert chamadosParaCriar;
            // 1. O Salesforce precisa de um Set com os IDs dos chamados que acabaram de nascer
            Set<Id> idsDosCasos = new Set<Id>();
            for (Case c : chamadosParaCriar) {
                idsDosCasos.add(c.Id);
            }
            
            // 2. Dispara a chamada assíncrona para a internet!
            GarantiaService.consultarGarantiaExterna(idsDosCasos);
        }
    }
}