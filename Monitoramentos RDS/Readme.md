# Remote Session Info

Esse script usa o módulo PSTerminalServices para obter informações sobre as sessões remotas ativas e inativas em um computador local. Ele aceita um parâmetro chamado `$select` que define o tipo de informação que será mostrada. Os valores possíveis para o parâmetro são:

- `ACTIVE`: mostra o nome do domínio, o nome de usuário, o nome do computador e o endereço IP das sessões remotas ativas.
- `ACTIVENUM`: mostra o número total de sessões remotas ativas.
- `INACTIVE`: mostra o nome do domínio e o nome de usuário das sessões remotas inativas, excluindo a sessão 0.
- `INACTIVENUM`: mostra o número total de sessões remotas inativas, excluindo a sessão 0.
- `DEVICE`: mostra o nome dos computadores remotos que estão conectados por sessões remotas ativas.
- `IP`: mostra os endereços IP dos computadores remotos que estão conectados por sessões remotas ativas.

## Exemplo de uso

Para executar o script, você precisa ter o módulo PSTerminalServices instalado no seu computador. Você pode instalar o módulo usando o comando:

```powershell
Install-Module PSTerminalServices

.\RemoteSessionInfo.ps1 -select ACTIVE

O resultado será algo como:

DOMAIN1\User1 PC1 192.168.1.10
DOMAIN2\User2 PC2 192.168.1.11
DOMAIN3\User3 PC3 192.168.1.12
Copiar
Você pode alterar o valor do parâmetro para ver outros tipos de informação, conforme descrito acima.

Licença
Esse script é de domínio público e pode ser usado livremente para fins pessoais ou comerciais, sem garantia ou suporte. Você pode modificar ou distribuir o script como quiser, desde que mantenha os créditos do autor original.

Autor
Esse script foi criado por [nome do autor], baseado no módulo PSTerminalServices de Shay Levy. Você pode entrar em contato com o autor pelo e-mail [e-mail do autor] ou pelo GitHub [link do GitHub do autor].