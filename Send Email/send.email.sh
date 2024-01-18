#!/bin/bash

# Recebendo argumentos do script
email=$1
event_name=$2
data_hora=$3
host_name=$4
event_duration=$5
status=$6

# API key e URL para a API do Brevo
api_key=""
url="https://api.brevo.com/v3/smtp/email"

# Ler o HTML do arquivo e substituir variáveis
template_html=$(</var/lib/zabbix/scriptzbx/email_alerta.html)
html_final="${template_html//\{event_name\}/$event_name}"
html_final="${html_final//\{data_hora\}/$data_hora}"
html_final="${html_final//\{host_name\}/$host_name}"
html_final="${html_final//\{event_duration\}/$event_duration}"
html_final="${html_final//\{status\}/$status}"

# Escapar caracteres especiais para JSON
html_final_escaped=$(echo "$html_final" | sed 's/"/\\"/g' | tr -d '\n' | tr -d '\r')

# Definir payload para a requisição POST
payload=$(cat <<EOF
{
    "sender": {
        "name": "NOC Wenz Tecnologia",
        "email": "alerta@wenzlab.tk"
    },
    "to": [
        {"email": "$email", "name": "Cliente"}
    ],
    "subject": "$status: $event_name $host_name $data_hora",
    "htmlContent": "$html_final_escaped"
}
EOF
)

# Enviar requisição POST para a API do Brevo
response=$(curl -s -o /dev/null -w "%{http_code}" -X POST $url \
    -H 'accept: application/json' \
    -H "api-key: $api_key" \
    -H 'content-type: application/json' \
    -d "$payload")

# Verificar se a requisição foi bem-sucedida
if [ "$response" = "200" ] || [ "$response" = "201" ]; then
    echo "E-mail enviado com sucesso!"
else
    echo "Erro ao enviar o e-mail. Status code: $response"
fi
