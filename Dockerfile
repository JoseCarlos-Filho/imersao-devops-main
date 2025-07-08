#FROM python:3.14.0b3-alpine3.22

# Use uma imagem oficial do Python como imagem pai
FROM python:3.10-slim

# Define o diretório de trabalho no container
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# Instala as dependências especificadas no requirements.txt
# --no-cache-dir: Desativa o cache, que não é necessário em uma imagem de container
# --upgrade pip: Garante que temos a versão mais recente do pip
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para permitir a comunicação de/para o container
EXPOSE 8000

# Comando para executar a aplicação quando o container for iniciado
# Use 0.0.0.0 como host para ser acessível de fora do container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]