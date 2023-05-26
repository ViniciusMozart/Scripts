Script de Monitoramento de Usuários Inativos no RDS
Este script em PowerShell permite monitorar e desconectar usuários inativos do Remote Desktop Services (RDS) com base em um tempo limite definido. Ele utiliza o comando quser para obter a lista de usuários conectados ao RDS e verifica se eles estão inativos por um período de tempo especificado. Se um usuário estiver inativo além do tempo limite, o script realizará o logoff forçado do usuário.

Requisitos
O script requer o PowerShell para ser executado.
Certifique-se de que o módulo RemoteDesktop esteja instalado no sistema onde o script será executado.
Como Usar
Abra o PowerShell no sistema em que o script será executado.

Copie e cole o código do script em um novo arquivo chamado monitoramento_rdp.ps1.

Edite a variável $inactiveTimeout para definir o tempo limite, em minutos, para considerar um usuário inativo. Por padrão, está configurado para 60 minutos.

Edite o parâmetro -server no comando quser para especificar o nome do servidor RDS em que deseja verificar os usuários conectados. Por exemplo, -server:BRAZUOSKTSP01.

Salve o arquivo monitoramento_rdp.ps1.

Execute o script executando o seguinte comando no PowerShell:

powershell
Copy code
.\monitoramento_rdp.ps1
O script começará a verificar os usuários conectados ao RDS e desconectará os usuários que estiverem inativos além do tempo limite definido.

Durante a execução, o script exibirá uma mensagem indicando quais usuários foram desconectados devido à inatividade.

Importante
Certifique-se de que o usuário que executa o script tenha as permissões adequadas para realizar logoff de sessões de usuário no servidor RDS.
Antes de executar o script em um ambiente de produção, teste-o em um ambiente de teste para garantir que ele funcione conforme esperado e se adapte às suas necessidades.
Aviso
O protocolo PPTP (Point-to-Point Tunneling Protocol) usado na autenticação VPN mencionada neste script é considerado inseguro. É recomendável utilizar protocolos VPN mais seguros, como o OpenVPN, IPSec ou outros, que oferecem recursos de segurança mais robustos.