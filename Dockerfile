# Use a imagem oficial do Ruby
FROM ruby:3.3.6

# Instalar dependências do sistema (para PostgreSQL e outras gemas)
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar o Gemfile e o Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instalar as dependências do Rails
RUN bundle install

# Copiar o restante do projeto para dentro do contêiner
COPY . .

# Expôr a porta em que o Rails será executado
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
