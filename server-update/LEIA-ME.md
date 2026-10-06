# Atualização do servidor — 06/10/2026

Pare o servidor e faça backup antes de copiar.
Copie o conteúdo de mods/ para mods/ do servidor Fabric 1.21.1 (Java 21, Cobblemon 1.7.3). Substitua versões anteriores dos mesmos mods; não deixe duas versões.
São 10 mods novos e suas bibliotecas. Fabric API e Cobblemon já devem existir no servidor. EmoteCraft e Player Animator permitem sincronizar os emotes; os arquivos de emotes ficam somente nos clients.
Copie config/ para config/ do servidor. O default_shop.json inclui Bottle Caps por 30.000 e Gold Bottle Caps por 150.000; revise se o servidor tem outras alterações nesse arquivo antes de substituir.
O limite de notificações de 128 blocos fica no client: config/cobblemon-spawn-alerts/main.json, distanceFilter enabled=true, minDistance=0, maxDistance=128. O servidor fornece os dados e cada client aplica o filtro. Não é uma restrição obrigatória para clients que alterem sua própria configuração.
Não instale FancyMenu, resource packs, shaders ou C2ME deste pacote no servidor. Remova/desative C2ME 0.4.0-alpha.0.23 se ainda estiver ativo com Java 21.
Reinicie e confira o log. Este pacote não foi executado no servidor remoto e não altera claims nem configurações do mundo.
