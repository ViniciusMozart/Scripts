# Define o tempo limite em minutos para considerar um usuário inativo
$inactiveTimeout = 60

# Obtém a data e hora atuais
$currentTime = Get-Date

# Obtém a lista de usuários conectados ao RDS
$users = quser /server:BRAZUOSKTSP01

# Loop através de cada linha da saída do comando quser
foreach ($user in $users) {
    $userInfo = $user.Trim() -split '\s+'
    $sessionUser = $userInfo[0]
    $sessionState = $userInfo[3]
    $sessionIdleTime = $userInfo[4]

    # Verifica se o estado da sessão é "Active" e o tempo ocioso é maior que o tempo limite definido
    if ($sessionState -eq "Active" -and $sessionIdleTime -ge $inactiveTimeout) {
        # Obtém o ID da sessão do usuário
        $sessionId = $userInfo[2]

        # Faz o logoff do usuário com a opção "force"
        Invoke-RDUserLogoff -HostServer BRAZUOSKTSP01 -UnifiedSessionID $sessionId -Force

        Write-Host "Usuário $sessionUser desconectado forçadamente devido à inatividade."
    }
}
