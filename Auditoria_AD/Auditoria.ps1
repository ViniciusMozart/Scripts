#Execuçõa
#.\Auditoria.ps1 -Assunto "Alerta de Problema" -Evento "Falha de Conexão" -Cliente "Empresa XYZ" -CorpoEmail "Detalhes do problema..." -Hostname "Srv" -EventRecordID "$(EventRecordID)" -EventChannel "$(Channel)"
# Carregar módulo dotenv para ler o arquivo .env
Import-Module dotenv
$envVars = Get-DotEnvEnvironment -Path "$PSScriptRoot\.env"

param(
    [String]$Assunto,
    [String]$Evento,
    [String]$Cliente,
    [String]$CorpoEmail,
    [String]$Hostname,
    [string]$EventRecordID,
    [string]$EventChannel
)
# Capturando detalhes do evento
$eventLog = Get-WinEvent -LogName $EventChannel | Where-Object { $_.RecordId -eq $EventRecordID }
$Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
# Agora, $eventLog contém detalhes do evento, que podem ser formatados e incluídos no e-mail

# Habilitar TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Vari�veis
$apiKey = $envVars['BREVO_API_KEY']
$Url = "https://api.brevo.com/v3/smtp/email"
$EmailPara = "suporte@wenz.com.br"
$NomeRemetente = "NOC Wenz Tecnologia"
$EmailRemetente = "alerta@wenzlab.tk"

# Preparar o HTML do corpo do e-mail
# Substitua o caminho do arquivo HTML conforme necess�rio
$TemplateHtml = Get-Content "C:\Script\email_alerta.html" -Raw
$HtmlFinal = $TemplateHtml -replace '\{evento\}', $Evento -replace '\{cliente\}', $Cliente -replace '\{corpo\}', $eventLog -replace '\{host_name\}', $Hostname -replace '\{data_hora\}', $Date

# Preparar o payload
$Payload = @{
    sender = @{
        name = $NomeRemetente
        email = $EmailRemetente
    }
    to = @(
        @{
            email = $EmailPara
            name = "Cliente"
        }
    )
    subject = $Assunto
    htmlContent = $HtmlFinal
} | ConvertTo-Json -Depth 10

# Enviar requisi��o POST
$Headers = @{
    "accept" = "application/json"
    "api-key" = $ApiKey
    "content-type" = "application/json"
}

try {
    $Response = Invoke-RestMethod -Uri $Url -Method Post -Headers $Headers -Body $Payload -UseBasicParsing
    Write-Host "E-mail enviado com sucesso!"
} catch {
    Write-Host "Erro ao enviar o e-mail."
    if ($_.Exception.Response) {
        $ResponseStream = $_.Exception.Response.GetResponseStream()
        $StreamReader = New-Object System.IO.StreamReader($ResponseStream)
        $ResponseObj = $StreamReader.ReadToEnd() | ConvertFrom-Json
        $StreamReader.Close()
        Write-Host "Status code: $($_.Exception.Response.StatusCode)"
        Write-Host "Detalhes do erro: $($ResponseObj.detail)"
    } else {
        Write-Host "A resposta não contém um corpo." + $Response
    }
}
