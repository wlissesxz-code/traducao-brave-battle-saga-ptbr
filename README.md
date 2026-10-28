# Brave Battle Saga — Tradução PT-BR

Tradução de fã para **Brave Battle Saga: The Legend of the Magic Warrior**, beta 1.2.
Textos extraídos traduzidos até o final da história, itens, magias e descrições; fontes com acentos e ç.
Ainda não foi revisada uma partida completa. Algumas imagens com texto, logotipo e menus permanecem em inglês.

## Compatibilidade

| Edição | Situação |
| --- | --- |
| GOG | Base de desenvolvimento; abertura executada e correções de SRAM verificadas no emulador. Revisão completa pendente. |
| Steam | Não testada. Só será aceita se `res/game` for idêntico ao original abaixo. Não há garantia de funcionamento do emulador Steam. |

É necessário possuir o jogo. Este pacote contém somente o patch e o aplicador; não inclui ROM, executável do jogo, emulador ou salvamentos.

## Instalação no Windows

1. Baixe o ZIP em **Releases** e extraia tudo para uma pasta.
2. Feche o jogo. Faça também uma cópia de segurança da pasta do jogo, especialmente `res/sram` e estados rápidos.
3. Execute `Instalar.cmd`. Quando solicitado, cole o caminho da pasta do jogo que contém a subpasta `res`.
4. O aplicador verifica o original, cria `res/game.original-ptbr.bak`, aplica o patch e confere o resultado. Versões diferentes são recusadas.
5. Abra o jogo pelo executável que já acompanha sua instalação.

O aplicador modifica somente `res/game` e cria seu backup. Não altera seus salvamentos ou configurações. Não precisa instalar Python. Pastas protegidas podem exigir permissão de escrita; pode-se testar numa cópia do jogo em outra pasta.

Para desfazer, feche o jogo, execute `Restaurar-original.cmd` e informe a mesma pasta. O backup é validado antes da restauração.
Atualizações da loja ou verificação de integridade podem repor o arquivo original.

## Salvamentos e limitações

Prefira salvamentos normais do próprio jogo entre versões. Estados rápidos também guardam a memória e podem restaurar dados antigos. Faça backup antes de atualizar.
Corrigidos o byte de ação após falas realocadas (incluindo a conversa sobre Hemo) e a habilitação da SRAM na ROM ampliada.
O pacote público não faz a limpeza particular dos espaços inválidos que foi necessária durante o desenvolvimento e não distribui progresso de terceiros.

Na fase inicial, informe problemas com imagem, local da cena e última fala. Não há confirmação de que todos os eventos e batalhas funcionem até o final.
A tradução dos menus do emulador feita no desenvolvimento não está incluída neste pacote; o executável original é mantido.

## Identificação dos arquivos

- Original: 2.097.152 bytes.
- SHA256 original: `3b89962935aadc8ae1b7db5b2556b38c8eff6035920f4bcb2f065d86da92d0ee`.
- Traduzido: 4.194.304 bytes.
- SHA256 traduzido: `33b1c8610a95e2d161dc2ce28fcaf786494ad09e2e22e93b8704755ad92d82f0`.

O mesmo IPS pode ser aplicado por outro aplicador compatível com expansão e tamanho final IPS, desde que o original corresponda ao SHA256 acima.

## Créditos

Projeto de tradução mantido por **wlissesxz-code**, com assistência de IA na tradução e nas ferramentas. Projeto não oficial, sem vínculo com os responsáveis pelo jogo. Nomes e conteúdos do jogo pertencem aos respectivos titulares.

## Colaboração

Use **Issues** para reportar problemas. Para testar a Steam, informe o SHA256 e o tamanho de `res/game`, a versão da loja e o resultado do teste. Não envie o jogo completo. Compatibilidade com outras ROMs requer análise e patch próprio.
