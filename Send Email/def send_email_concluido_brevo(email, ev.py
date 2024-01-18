def send_email_concluido_brevo(email, event_name, data_hora,host_name, formato='html'):
    # Configurações da API do Brevo
    api_key = 'api_key'
    url = 'https://api.brevo.com/v3/smtp/email'

    # Ler o HTML do arquivo
    with open('email_concluido.html', 'r', encoding='utf-8') as file:
        template_html = file.read()

    # Substituir variáveis
    html_final = template_html.format(event_name=event_name, data_hora=data_hora, host_name=host_name)

    # Definir payload para a requisição POST
    payload = {
        "sender": {
            "name": "NOC Wenz Tecnologia",
            "email": "alerta@wenzlab.tk"
        },
        "to": [
            
                {"email": email, "name": "Cliente"},
            
        ],
        "subject": f"Problema: {event_name} {host_name} {data_hora}",
        "htmlContent": html_final
    }

    # Configurar cabeçalhos da requisição
    headers = {
        'accept': 'application/json',
        'api-key': api_key,
        'content-type': 'application/json'
    }

    try:
        # Enviar requisição POST para a API do Brevo
        response = requests.post(url, json=payload, headers=headers)

        # Verificar se a requisição foi bem-sucedida
        if response.status_code == 200 or 201:
            print("E-mail enviado com sucesso!")
        else:
            print(f"Erro ao enviar o e-mail. Status code: {response.status_code}, Response: {response.text}")
    except Exception as e:
        print(f"Erro ao enviar o e-mail: {e}")
