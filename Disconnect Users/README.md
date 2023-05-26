<h1 align="center">SCRIPT PARA DESCONECTAR USUÁRIOS INATIVOS 👋</h1>


## Meu script

Aqui está o script que eu criei para definir o tempo limite em minutos para considerar um usuário inativo no RDS:

```powershell
# Define o tempo limite em minutos para considerar um usuário inativo
$inactiveTimeout = 30

# Obtém a data e hora atuais
$currentTime = Get-Date

# Obtém a lista de usuários conectados ao RDS
$users = quser /server:<server_name>

# Loop através de cada linha da saída do comando quser
foreach ($user in $users) {
    $userInfo = $user.Trim() -split '\s+'
    $sessionUser = $userInfo[0]
    $sessionState = $userInfo[2]
    $sessionIdleTime = $userInfo[3]

    # Verifica se o estado da sessão é "Active" e o tempo ocioso é maior que o tempo limite definido
    if ($sessionState -eq "Active" -and $sessionIdleTime -ge $inactiveTimeout) {
        # Obtém o ID da sessão do usuário
        $sessionId = $userInfo[1]

        # Faz o logoff do usuário com a opção "force"
        Invoke-RDUserLogoff -HostServer <server_name> -UnifiedSessionID $sessionId -Force

        Write-Host "Usuário $sessionUser desconectado forçadamente devido à inatividade."
    }
}
