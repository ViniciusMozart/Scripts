<h1 align="center">Olá, eu sou Fulano de Tal 👋</h1>
<p align="center">
  <img src="https://img.shields.io/github/followers/fulanodetal?style=social">
  <img src="https://img.shields.io/github/stars/fulanodetal?style=social">
  <img src="https://img.shields.io/twitter/follow/fulanodetal?style=social">
</p>

## Sobre mim

Sou um desenvolvedor apaixonado por PowerShell e automação de tarefas. Trabalho como administrador de sistemas em uma empresa de tecnologia e gosto de compartilhar meus conhecimentos e projetos no GitHub.

## Meus projetos

Aqui estão alguns dos meus projetos que eu criei ou contribuí:

- [GlicoCare](https://github.com/fulanodetal/GlicoCare): Um aplicativo para monitorar os níveis de glicose no sangue.
- [PowerShellScripts](https://github.com/fulanodetal/PowerShellScripts): Uma coleção de scripts úteis em PowerShell para diversas situações.
- [Docusaurus](https://github.com/facebook/docusaurus): Um projeto do Facebook para criar, implantar e manter sites de projetos de código aberto.

## Minhas habilidades

- PowerShell
- C#
- HTML
- CSS
- JavaScript
- React
- SQL Server
- Azure

## Meus contatos

Você pode me encontrar nas seguintes redes sociais:

- [LinkedIn](https://www.linkedin.com/in/fulanodetal/)
- [Twitter](https://twitter.com/fulanodetal)
- [Instagram](https://www.instagram.com/fulanodetal/)

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
