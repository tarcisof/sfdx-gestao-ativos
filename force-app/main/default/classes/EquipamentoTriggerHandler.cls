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
        
        // Linha 29 agora vai rodar lisa!
        if (!chamadosParaCriar.isEmpty()) {
            insert chamadosParaCriar;
        }
    }
}