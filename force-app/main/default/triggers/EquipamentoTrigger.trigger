trigger EquipamentoTrigger on Equipamento__c (after update) {
    
    if (Trigger.isAfter && Trigger.isUpdate) {
        // Chama a classe enviando a lista com os dados novos e o mapa com os dados antigos
        EquipamentoTriggerHandler.verificarEquipamentoComDefeito(Trigger.new, Trigger.oldMap);
    }
    
}